//
//  BaseViewModel.swift
//  MvvmRxSwift
//
//  Created by Adeel Kiani on 17/10/2019.
//  Copyright © 2019 Adeel Kiani. All rights reserved.
//

import Foundation
import  RxSwift
import JWTDecode
import UserNotifications

enum notificationActionTypes {
  case SNOOZE_READ
}

class BaseViewModel{

  
  private static var dataManager : DataManager!
  let disposeBag = DisposeBag()
  static var jwtData:JWTResponseModel?
  let BASE_VIEWMODEL_TAG = "BASE_VIEWMODEL"


  //Creating single instancce for DataManager layer
   init() {
       if BaseViewModel.dataManager==nil{
        BaseViewModel.dataManager = DataManager(preferences: AppUserDefaults(userDefault: UserDefaults.standard), network: NetworkService(), sqliteHelper: SQLiteHelper(alertRepository: AlertRepository()))
               
        if let jwt = BaseViewModel.dataManager.preferences.JWTToken {
          decodeJWT(jwt: jwt)
        }

        print("DATA MANAGER INITIALIZED")
       }
   
   }
  
  
  func getDataManager() -> DataManager {
      
      return BaseViewModel.dataManager
  }
  
  ///Jwt Model
  func getJwtData() -> JWTResponseModel? {
    return BaseViewModel.jwtData

  }
  
  ///Decodes JWT Token and parse it to data model for JWT
  func decodeJWT(jwt:String) {
    
    do {
      let jwt = try decode(jwt: jwt)
      let jsonData = try JSONSerialization.data(withJSONObject: jwt.body, options: .prettyPrinted)
      let dataModel = try JSONDecoder().decode(JWTResponseModel.self, from: jsonData)

      BaseViewModel.jwtData = dataModel
      
      
    } catch let error {
      print("Unable to decode JWT: \(error.localizedDescription)")
    }
    
  }
  
  ///Function used to clear database, preferences, remove pending/delivered notifications and remove directories
  func clearSessionOnLogout(logout: @escaping ()->()) {
    
    let parameters = [
    "pushKitToken": getDataManager().preferences.voipToken ?? "",
    "deviceToken": getDataManager().preferences.deviceToken ?? "",
    ]
    
    let jwtToken = getDataManager().preferences.JWTToken ?? ""
    
    getDataManager().network.makeRequest(model: SuccessResponseModel.self, path: API_LOGOUT, method: .post, parameters: parameters, jwtToken: jwtToken, onResult: { response in
      
      response.subscribe(onNext: { result in
        
        
      }).disposed(by: self.disposeBag)
      
      }) { error in
      
    }
    
    
    getDataManager().preferences.isLoggedIn = false
    getDataManager().preferences.JWTToken = ""
    getDataManager().preferences.isFirstTimeLoggedIn = "true"
    logout()
    UIApplication.shared.applicationIconBadgeNumber = 0

  }
  
  func updateJWTToken(jwtToken:String?){
    
    if let _jwtToken = jwtToken {
      getDataManager().preferences.JWTToken = _jwtToken
      decodeJWT(jwt: _jwtToken)
    }

  }
  
  func getTwillioAccessToken(url:String,compeletionHandler:@escaping (_ accessToken:String?)->()) {
    
     
    getDataManager().network.makeRequestTwillioAccessToken(model: String.self, path: url, method: .get, onResult: { response in
      
             compeletionHandler(response)

      
      }) { error in
        print("AccessToken error: \(error ?? "Unable to get Access Token")")
        compeletionHandler(nil)
    }
    
    
  }
  
  func getJwtTokenApi(){
    
    let parameters = [:] as [String:Any]
    
    let jwtToken = getDataManager().preferences.JWTToken ?? ""
     
     getDataManager().network.makeRequest(model: SuccessResponseModel.self, path: API_GET_JWT, method: .get, parameters: parameters, jwtToken: jwtToken, onResult: { response in
       
       response.subscribe(onNext: { result in
         
        self.updateJWTToken(jwtToken: result.jwt)
        
       }).disposed(by: self.disposeBag)
       
       }) { error in
     }
  }
  
  ///Returns true if user is allowed to execute particular API
  func checkPrivilegeType(action:SCREEN_ACTIONS) -> Bool{
    
    
    if let jwtModel = getJwtData() {
      
      if let screenActions = jwtModel.screenActionCode {
        
        if screenActions.contains(where: {$0.caseInsensitiveCompare(action.rawValue) == .orderedSame}) {
          return true
        } else {
          return false
        }
      }
    }
    return false
  }
  
  
  ///Takes folder object and returns created directory path
  func createFolderDirectory(folder:Folder?,folderCreation:@escaping (_ isCreated:Bool,_ folderPath:String?)->()) {
    
       if let _folder = folder {
         if let _path = _folder.folderPath  {
           
           let directory = _path.deletingPrefix(BASE_DIRECTORY_PATH)

           createDirectory(folderName: directory) { (isCreated, path) in
             
            folderCreation(isCreated,directory)

        }
      }
    }
  }
  
///Takes folderName(path) with deleted prefix from base path of the folder
  fileprivate func createDirectory(folderName:String,folderCreation:@escaping (_ isCreated:Bool,_ folderPath:String?)->()){
    
    let fileManager = FileManager.default
    if let tDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
        let filePath =  tDocumentDirectory.appendingPathComponent(folderName)
        if !fileManager.fileExists(atPath: filePath.path) {
            do {
                try fileManager.createDirectory(atPath: filePath.path, withIntermediateDirectories: true, attributes: nil)
              folderCreation(true,filePath.path)
            } catch {
              folderCreation(true,nil)
                NSLog("Couldn't create document directory")
            }
        } else {
          folderCreation(true,filePath.path)
      }
    }
  }
  
  func createFolderDirectoryFromPath(folderPathWithName:String,folderCreation:@escaping (_ isCreated:Bool,_ folderPath:String?)->()){
    
    let fileManager = FileManager.default
    if let tDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
        let filePath =  tDocumentDirectory.appendingPathComponent(folderPathWithName)
        if !fileManager.fileExists(atPath: filePath.path) {
            do {
                try fileManager.createDirectory(atPath: filePath.path, withIntermediateDirectories: true, attributes: nil)
              folderCreation(true,filePath.path)
            } catch {
              folderCreation(true,nil)
                NSLog("Couldn't create document directory")
            }
        } else {
          folderCreation(true,filePath.path)
      }
    }
  }
  
  func removeDirectory() {
    
    let fileManager = FileManager.default

    if let tDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {

      do {
        let filePath =  tDocumentDirectory.appendingPathComponent(getJwtData()?.businessName ?? "mvvm-demo")
        try fileManager.removeItem(at: filePath)
        
      } catch  {
        print("Unable to delete directory")
      }
    }
  }
  
  func readFilePathFromDirectory(basePath:String,filePath: @escaping (_ path:URL?)->()){
    
    let directory = basePath.deletingPrefix(BASE_DIRECTORY_PATH)

    let fileManager = FileManager.default
      if let tDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
          let path =  tDocumentDirectory.appendingPathComponent(directory)
        
          if fileManager.fileExists(atPath: path.path) {
            filePath(path)
          } else {
            filePath(nil)
        }
    }
  }
  
  ///Create file name with appending type id and name
  func formateFileNameToBeSaved(id:Int,name:String)->String{
    
    return "\(String(id))-\(name).html"
    
  }
  
  ///Download file to specific path 
  func downloadFileToPath(directoryWithFileName:String,fileURL:String,result: @escaping ((_ isDownlaoded:Bool,_ error:String?) -> ())) {
    
    DispatchQueue.global(qos: .background).async {

      
      self.getDataManager().network.downloadFileToDirectory(url: fileURL, method: .get, directory: directoryWithFileName, result: { (isDownlaoded, data) in
        
        if isDownlaoded {
          print("FILE DOWNLOADING RESULT: \(data)")
          result(true,data)

        } else {
          
          print("FILE DOWNLOADING ERROR: \(data)")
          result(false,nil)
        }
        
    }) { error in
      
      }
    }
  }
  
  ///Returns device type with device version eg. ios13
  func getDeviceType()->String {
    let deviceVersion = UIDevice.current.systemVersion
    let version = deviceVersion.split(separator: ".")
      return "ios\(version[0])"
    
  }
  
}
