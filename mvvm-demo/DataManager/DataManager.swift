//
//  DataManager.swift
//  MvvmRxSwift
//
//  Created by Adeel Kiani on 18/10/2019.
//  Copyright © 2019 Adeel Kiani. All rights reserved.
//

import Foundation

class DataManager {
        
//      private static let instance: DataManager = {
//          return DataManager()
//      }()
  
    private init() {}
      
    var preferences: AppUserDefaults!
    var sqlite: SQLiteHelper!
    var network: NetworkService!
    
//  var instance = DataManager(preferences: AppUserDefaults(userDefault: UserDefaults.standard), network: NetworkService(), sqliteHelper: SQLiteHelper())

    init(preferences : AppUserDefaults, network: NetworkService, sqliteHelper: SQLiteHelper) {

        self.preferences = preferences
        self.network = network
        self.sqlite = sqliteHelper
    }
    
}
