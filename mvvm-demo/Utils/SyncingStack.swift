//
//  SyncingQueue.swift
//  mvvm-demo
//
//  Created by Adeel Kiani on 21/01/2020.
//

import Foundation

import Foundation
struct SyncingStack {
  
  fileprivate var array: [CATEGORY_TYPE] = []

  mutating func push(_ element: CATEGORY_TYPE) {
    array.insert(element, at: 0)
  }

  
  mutating func removeCompletedTask(type:CATEGORY_TYPE,remainingTask:@escaping (_ count:Int)->()){
  
    array.removeAll(where: {$0.rawValue == type.rawValue})
    remainingTask(array.count)
    
  }
}
