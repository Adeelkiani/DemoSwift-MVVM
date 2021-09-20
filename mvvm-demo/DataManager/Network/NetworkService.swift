//
//  NetworkService.swift
//  MvvmRxSwift
//
//  Created by Adeel Kiani on 18/10/2019.
//  Copyright © 2019 Adeel Kiani. All rights reserved.
//

import Foundation
import RxAlamofire
import RxSwift
import Alamofire

class NetworkService {
    //
//    static let shared: NetworkService = {
//        return NetworkService()
//    }()
//
//    private init() {}
    
    let disposeBag = DisposeBag()
    
  
   ///This function is used to call API with parameters in GET/POST request.
   func makeStringRequest<T: Decodable> (model: T.Type, path: String, method: HTTPMethod, parameters: [String: Any],jwtToken:String,timeout:Int = 30, onResult: @escaping ((Observable<T>) -> ()), onError: @escaping ((String?) -> ())) {
                 
     let header = [
            "Authorization": "\(jwtToken)"
          ]
          
         
         RxAlamofire.requestString(method, path, parameters: parameters, encoding: URLEncoding(),headers: header)
           .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
           .timeout(.seconds(timeout), scheduler: ConcurrentDispatchQueueScheduler(qos: .background))
          .subscribe({ (response) in
            
            print("\(path) API STATUS CODE: \(response.error?.localizedDescription ?? "error")")
             
         }).disposed(by: disposeBag)
         
     }
  
  
  
  
  ///This function is used to call API with parameters in GET/POST request.
  func makeRequest<T: Decodable> (model: T.Type, path: String, method: HTTPMethod, parameters: [String: Any],jwtToken:String,timeout:Int = 30, onResult: @escaping ((Observable<T>) -> ()), onError: @escaping ((String?) -> ())) {
                
    let header = [
           "Authorization": "\(jwtToken)"
         ]
         
        
        RxAlamofire.requestData(method, path, parameters: parameters, encoding: URLEncoding(),headers: header)
          .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
          .timeout(.seconds(timeout), scheduler: ConcurrentDispatchQueueScheduler(qos: .background))
          .subscribe(onNext: { (response: HTTPURLResponse, data: Data) in
            print("\(path) API STATUS CODE: \(response.statusCode)")
            do {
                
              let decodedData = try JSONDecoder().decode(model.self, from: data)
              let observableSequence = Observable<T>.just(decodedData)
              
              DispatchQueue.main.async {
              onResult(observableSequence)
              }
                
            } catch let error {
              print("API ERROR: PATH: \(path)  MESSAGE: \(error.localizedDescription)")

              DispatchQueue.main.async {
              if response.statusCode == 500 {
                onError("Something went wrong")
              } else {
                onError(error.localizedDescription)
              }
              }
            }
            
        }, onError: { (error: Error) in
          
          onError(error.localizedDescription)

          print("API ERROR: PATH: \(path)  MESSAGE: \(error.localizedDescription)")

        }).disposed(by: disposeBag)
        
    }
    
  
  ///This function is used for sending object in post request API
  func makeRequestWithBody<T: Decodable> (model: T.Type, path: String, method: HTTPMethod, body: [String: Any],jwtToken:String, timeout:Int = 30, onResult: @escaping ((Observable<T>) -> ()), onError: @escaping ((String?) -> ())) {
       
    let header = [
         "Authorization": "\(jwtToken)"
       ]
       
       RxAlamofire.requestData(method, path, parameters: body,headers: header)
          .observeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
         .timeout(.seconds(timeout), scheduler: ConcurrentDispatchQueueScheduler(qos: .background))
         .subscribe(onNext: { (response: HTTPURLResponse, data: Data) in
          
//          print("API STATUS CODE: \(response.statusCode)")

           do {
               
               let decodedData = try JSONDecoder().decode(model.self, from: data)
               let observableSequence = Observable<T>.just(decodedData)
              DispatchQueue.main.async {

               onResult(observableSequence)
               
            }
           } catch let err {
             
            print("API ERROR: PATH: \(path)  MESSAGE: \(err.localizedDescription)")
            DispatchQueue.main.async {

               if response.statusCode == 500 {
                 onError("Something went wrong")
               } else {
                 onError(err.localizedDescription)
               }
              }
            }
           
       }, onError: { (error: Error) in
        DispatchQueue.main.async {
          onError(error.localizedDescription)
           print("API ERROR: PATH: \(path)  MESSAGE: \(error.localizedDescription)")
        }
       }).disposed(by: disposeBag)
       
   }
  
  
   ///This function is used to call API with parameters in GET/POST request without JSON response.
   func makeRequestTwillioAccessToken<T: Decodable> (model: T.Type, path: String, method: HTTPMethod,timeout:Int = 30, onResult: @escaping ((String) -> ()), onError: @escaping ((String?) -> ())) {
                 
    RxAlamofire.requestString(method, path)
      .timeout(.seconds(timeout), scheduler: ConcurrentDispatchQueueScheduler(qos: .background))
      .subscribe(onNext: { (response,data) in
        

        if response.statusCode == 200 {

          
            onResult(data)
    
        } else {
              onError("Something went wrong")
        }
          
        
      }, onError: { error in
                 
                 onError(error.localizedDescription)

                 print("API ERROR: PATH: \(path)  MESSAGE: \(error.localizedDescription)")

      }).disposed(by: disposeBag)
     }
  
  //NOTE CHANGE THIS TO RXALMOFIRE AFTER TESTING
  ///Function used to download file
  func downloadFileToDirectory ( url: String, method: HTTPMethod,directory:String, result: @escaping ((_ isDownlaoded:Bool,_ error:String?) -> ()), error: @escaping ((String?) -> ())) {

    
     let destination: DownloadRequest.DownloadFileDestination = { _, _ in
         var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
      documentsURL.appendPathComponent("\(directory)")
      
      return (documentsURL, [.removePreviousFile])
     }
    
    let appendCharacterToSpace = url.trimmed.replacingOccurrences(of: " ", with: "%20")
    
    
     Alamofire.download(
         appendCharacterToSpace,
         method: .get,
         encoding: JSONEncoding.default,
         headers: nil,
         to: destination).downloadProgress(closure: { (progress) in
             //progress closure
         })
      .response(completionHandler: { (response) in
          
          if let error = response.error {
            print("FILE DOWNLOADING ERROR: \(error.localizedDescription)")

            result(false,error.localizedDescription)
          } else {
            if let url = response.destinationURL {
              result(true,url.path)
            }
          }
      })
   }
  
  ///Upload with image
  func makeRequestUploadImage<T: Decodable> (modelType: T.Type,path: String, requestType: HTTPMethod, parameters: Parameters,jwtToken: String,imageData: Data,imgURL:String, timeout:Int = 30,imageParameterName:String, onResult: @escaping ((Observable<T>) -> ()), onError: @escaping ((String?) -> ())) {

      let header = [
          "Authorization": "\(jwtToken)"
      ]
    Alamofire.upload(multipartFormData: { (mData) in
         
         mData.append(imageData, withName: imageParameterName, fileName: "\(imgURL)", mimeType: "\(imgURL)")

      
           for (key, value) in parameters {
            
            if let _value = value as? String {
            mData.append("\(_value)".data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName :"\(key)")
            }
            if let _value = value as? Int64 {
              mData.append("\(_value)".data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName :"\(key)")
              }
            if let _value = value as? Int {
           
              mData.append("\(_value)".data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName :"\(key)")
            }
            
             if let _value = value as? Bool {
            
               mData.append("\(_value)".data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName :"\(key)")
             }
          }
         
     }, usingThreshold: UInt64.init(), to:path, method: .post, headers: header) { (result) in
         switch result {
         case .success(let upload, _, _):
             upload.responseData(completionHandler: { (response) in
                 
                 if response.result.error == nil {
                     
                     guard let data = response.data else { return }
                     
            
                     do {
                         
                         let decodedData = try JSONDecoder().decode(modelType.self, from: data)
                    let observableSequence = Observable<T>.just(decodedData)
                      DispatchQueue.main.async {

                        onResult(observableSequence)
                                   
                        }
                         
                     } catch let jsonErr {
                         
                      onError(jsonErr.localizedDescription)

                     }
                     
                 } else {
                  onError(response.error?.localizedDescription)
                 }
             })
         case .failure(let error):
        onError(error.localizedDescription)

      }
    }
  }
}

