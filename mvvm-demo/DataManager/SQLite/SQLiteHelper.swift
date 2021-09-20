//
//  File.swift
//  MvvmRxSwift
//
//  Created by Adeel Kiani on 18/10/2019.
//  Copyright © 2019 Adeel Kiani. All rights reserved.
//

import Foundation

//Generic model to be returned when response is success
enum SQLResult<T> {
  case onSuccess(result: T)
  case onError(errorCode: Int, message: String)
}

typealias onSQLResponse<T> = (_ onResult: SQLResult<T>) -> ()

class SQLiteHelper {
  
  var alertRepository:AlertRepositoryProtocol!

  init(alertRepository:AlertRepository) {
    
    self.alertRepository = alertRepository

  }
  
}
