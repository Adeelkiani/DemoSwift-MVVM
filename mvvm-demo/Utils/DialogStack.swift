//
//  DialogStack.swift
//  mvvm-demo
//
//  Created by Adeel Kiani on 08/01/2020.
//

import Foundation
struct DialogStack {
  
  fileprivate var array: [[AnyHashable: Any]] = []

  mutating func push(_ element: [AnyHashable: Any]) {
    array.insert(element, at: 0)
  }
  
  mutating func pop() -> [AnyHashable: Any]? {
    return array.popLast()
  }
  
  mutating func removePendingDialogs(typeId:Int,notificationType:String){
    
    array.removeAll(where: {
      
     if let _notificationType =  $0[NOTIFICATION_KEY_NOTIFICATION_TYPE] as? String,let _typeId =  $0[NOTIFICATION_KEY_NOTIFICATION_TYPE_ID] as? Int {
        
      if _notificationType == notificationType && _typeId == typeId {
        
        return true
        }
        
      }
      return false
    })
    
  }
  
  mutating func clearAll(){
    return array.removeAll()
   }
}
