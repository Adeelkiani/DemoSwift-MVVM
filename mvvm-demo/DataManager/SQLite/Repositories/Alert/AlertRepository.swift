//
//  AlertRepository.swift
//  mvvm-demo
//
//  Created by Adeel Kiani on 06/12/2019.
//

import Foundation
import GRDB
import RxSwift


protocol AlertRepositoryProtocol {
 //ALERT SQLITE
//  func InsertAlert(alertid: Int, name: String,summary:String, feedback: String, path: String, creationdate: Int64, modificationdate: Int64?, status: String, state: String, rstatus: String, businessId: Int,favourite:Bool) -> PrimitiveSequence<SingleTrait, AlertSQLite?>
//  func deleteAlert(alertid:Int) -> Completable


}


class AlertRepository : AlertRepositoryProtocol {

    
  //--------------------------------------------------------------//
  //--------------------------------------------------------------//
  //--------------------------------------------------------------//
  //------------------------ ALERT SQLITE ------------------------//
  //--------------------------------------------------------------//
  //--------------------------------------------------------------//
  //--------------------------------------------------------------//
  
//  func InsertAlert(alertid: Int, name: String,summary:String, feedback: String, path: String, creationdate: Int64, modificationdate: Int64?, status: String, state: String, rstatus: String, businessId: Int,favourite:Bool) -> PrimitiveSequence<SingleTrait, AlertSQLite?> {
//
//    return database.rx.write(updates: { db  in
//
//      var alert = AlertSQLite(alertid: alertid, name: name,summary: summary,feedback: feedback, path: path, creationdate: creationdate, modificationdate: modificationdate, status: state, state: state, rstatus: rstatus, businessId: businessId,favourite: favourite)
//
//      try alert.insert(db)
//
//    }) { _db, _ in
//
//      try (AlertSQLite.fetchOne(_db, sql: "SELECT * FROM \(TB_ALERT) where \(TBC_ALERT_ID)=\(alertid)") ?? nil)!
//
//    }
//  }
//
//
//  func deleteAlert(alertid: Int) -> Completable {
//
//     return database.rx.write(updates: { db  in
//
//       try  AlertSQLite.deleteOne(db, key: alertid)
//
//     })
//   }

}
