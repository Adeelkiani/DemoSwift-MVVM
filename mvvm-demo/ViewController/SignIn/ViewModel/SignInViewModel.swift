//
//  SignInViewModel.swift
//  MvvmRxSwift
//
//  Created by Adeel Kiani on 13/10/2019.
//  Copyright © 2019 Adeel Kiani. All rights reserved.
//

import Foundation
import RxSwift

class SignInViewModel:BaseViewModel{

  let employeeId = BehaviorSubject(value: "")
  let password = BehaviorSubject(value: "")
  var eventType:PublishSubject<SIGNIN_ACTIONS>!

  override init() {
    
  }
  convenience init(eventType:PublishSubject<SIGNIN_ACTIONS>) {
    self.init()
    self.eventType = eventType
     
    Observable.combineLatest(self.employeeId, self.password).map { $0.0.trimmed != "" && $0.1.trimmed != "" }
    .asObservable()
    .observeOn(MainScheduler.instance)
    .subscribe (
      onNext: {  result in
          
        eventType.onNext(.IS_SIGNIN_ACTIVE(result))
    })
    .disposed(by: disposeBag)
    
  }
  
  func clearRecords(){
    
    
     getDataManager().preferences.isLoggedIn = false
     getDataManager().preferences.JWTToken = ""
     getDataManager().preferences.isFirstTimeLoggedIn = "true"
     UIApplication.shared.applicationIconBadgeNumber = 0
    
   
  }
  
  
  func onSignInTapped(employeeCode:String,password:String) {
    let parameters = [
             "userCode": employeeCode,
             "password": password,
             "pushKitToken": getDataManager().preferences.voipToken ?? "",
             "deviceToken": getDataManager().preferences.deviceToken ?? "",
             "device": getDeviceType(),

         ]
    getDataManager().network.makeRequest(model: LoginResponse.self, path: API_SIGNIN, method: .post, parameters: parameters, jwtToken: "", onResult: { response in
        
             response.subscribe(
              onNext: { model in

                if let status = model.status {
                  if status.caseInsensitiveCompare("error") == .orderedSame {
                    self.eventType.onNext(.onError(errorMessage: model.message ?? ""))

                  } else {
              
                    if let isFirstTime = self.getDataManager().preferences.isFirstTimeLoggedIn {
                      self.eventType.onNext(.onSuccess(isFirstTimeLoggedIn: isFirstTime))
                    } else {
                      self.eventType.onNext(.onSuccess(isFirstTimeLoggedIn: "true"))
                    }
                    
                    self.getDataManager().preferences.isLoggedIn = true
                    self.updateJWTToken(jwtToken: model.jwt)
                    self.decodeJWT(jwt: model.jwt ?? "")
                    
                  }
                }
                
             }).disposed(by: self.disposeBag)
      
    }) { [weak self] error in
      
      self?.eventType.onNext(.onError(errorMessage: error ?? ""))

    }
        
  }
  

}
