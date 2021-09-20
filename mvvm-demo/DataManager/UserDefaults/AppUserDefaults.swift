//
//  UserDefaults.swift
//  MvvmRxSwift
//
//  Created by Adeel Kiani on 18/10/2019.
//  Copyright © 2019 Adeel Kiani. All rights reserved.
//

import Foundation

class AppUserDefaults {

  let defaults : UserDefaults!
  
  init(userDefault : UserDefaults) {
       self.defaults = userDefault
   }
  
  var isFirstTimeLoggedIn: String? {
        get {
            return defaults.value(forKey: DEFAULT_KEY_IS_FIRST_TIME_LOGIN) as? String
        } set {
            defaults.set(newValue, forKey: DEFAULT_KEY_IS_FIRST_TIME_LOGIN)
        }
    }
  
  var JWTToken: String? {
       get {
           return defaults.value(forKey: DEFAULT_KEY_JWT_TOKEN) as? String
       } set {
           defaults.set(newValue, forKey: DEFAULT_KEY_JWT_TOKEN)
       }
   }
  
  var decodedJWTObject: JWTResponseModel? {
       get {
        
        var _mappedObject:JWTResponseModel!
        if let object = defaults.object(forKey: DEFAULT_KEY_JWT_OBJECT) as? Data {
            let decoder = JSONDecoder()
            if let mappedObject = try? decoder.decode(JWTResponseModel.self, from: object) {
              _mappedObject = mappedObject
            }
        }
        return _mappedObject
      } set {
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(newValue) {
           defaults.set(newValue, forKey: DEFAULT_KEY_JWT_OBJECT)
        }
       }
   }
   
  var voipToken: String? {
        get {
            return defaults.value(forKey: DEFAULT_KEY_VOIP_TOKEN) as? String
        } set {
            defaults.set(newValue, forKey: DEFAULT_KEY_VOIP_TOKEN)
        }
    }

  var deviceToken: String? {
        get {
            return defaults.value(forKey: DEFAULT_KEY_DEVICE_TOKEN) as? String
        } set {
            defaults.set(newValue, forKey: DEFAULT_KEY_DEVICE_TOKEN)
        }
    }
  
  var isLoggedIn: Bool? {
         get {
             return defaults.bool(forKey: DEFAULT_KEY_IS_LOGGED_IN)
         } set {
             defaults.set(newValue, forKey: DEFAULT_KEY_IS_LOGGED_IN)
         }
     }
}
