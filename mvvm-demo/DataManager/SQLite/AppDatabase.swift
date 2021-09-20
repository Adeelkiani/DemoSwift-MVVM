//
//  AppDatabase.swift
//  mvvm-demo
//
//  Created by Adeel Kiani on 29/11/2019.
//

import Foundation
import GRDB

struct AppDatabase {

   
  
    /// Creates a fully initialized database at path
    func setup(_ database: DatabaseQueue) {
        
      do {
      try migrator.migrate(database)
      } catch let error {
        print("DATABASE ERROR: \(error.localizedDescription)")
      }
    }
  
  var migrator: DatabaseMigrator {
      var migrator = DatabaseMigrator()
      
//      migrator.eraseDatabaseOnSchemaChange = true

      
      migrator.registerMigration("v1") { dbInstance in
        
        self.CreateTables(db: dbInstance)

      }
    
    
    migrator.registerMigration("v2") { dbInstance in

          self.AlterTables(db: dbInstance)

        }

      return migrator
    }

  
     func AlterTables(db:Database) {
      
       do {
  
        // ANNOUNCEMENT TABLE
                   try db.create(table: TB_ANNOUNCEMENT,ifNotExists: true) { t in
                   t.column(TBC_ANNOUNCEMENT_ID,.integer).primaryKey(onConflict: .abort, autoincrement: false)
                   t.column(TBC_ANNOUNCEMENT_NAME, .text)
                   t.column(TBC_ANNOUNCEMENT_FEEDBACK, .text)
                   t.column(TBC_ANNOUNCEMENT_PATH, .text)
                   t.column(TBC_ANNOUNCEMENT_CREATION_DATE, .datetime)
                   t.column(TBC_ANNOUNCEMENT_MODIFICATION_DATE, .datetime)
                   t.column(TBC_ANNOUNCEMENT_STATE, .text)
                   t.column(TBC_ANNOUNCEMENT_CREATEBY, .text)
                   t.column(TBC_ANNOUNCEMENT_DESCRIPTION, .text)
                   t.column(TBC_ANNOUNCEMENT_STATUS, .text)
                   t.column(TBC_ANNOUNCEMENT_RSTATUS, .text)
                   t.column(TBC_ANNOUNCEMENT_BUSINESSID, .integer)
                   t.column(TBC_ANNOUNCEMENT_FAVOURITE, .boolean)
          
                  }
          
          
                 // ANNOUNCEMENT SETTING TABLE
                 try db.create(table: TB_ANNOUNCEMENT_SETTING,ifNotExists: true) { t in
                   t.column(TBC_ANNOUNCEMENT_SETTING_ID,.integer).primaryKey(onConflict: .abort, autoincrement: false)
                   t.column(TBC_ANNOUNCEMENT_SETTING_ANNOUNCEMENT_ID_FK, .integer).notNull().references(TB_ANNOUNCEMENT, onDelete: .cascade, onUpdate: .cascade)
                   t.column(TBC_ANNOUNCEMENT_SETTING_STAY_TIME, .integer)
                   t.column(TBC_ANNOUNCEMENT_SETTING_NOTIFICATION_TYPE, .text)
                   t.column(TBC_ANNOUNCEMENT_SETTING_OCCURRENCE, .integer)
                   t.column(TBC_ANNOUNCEMENT_SETTING_LOCAL_OCCURRENCE, .integer)
                   t.column(TBC_ANNOUNCEMENT_SETTING_RECURRENCE, .integer)
                   t.column(TBC_ANNOUNCEMENT_SETTING_CREATION_DATE, .datetime)
                   t.column(TBC_ANNOUNCEMENT_SETTING_MODIFICATION_DATE, .datetime)
                   t.column(TBC_ANNOUNCEMENT_SETTING_DISPLAY_TIME, .datetime)
          
                   }
        
        
        
        //ANNOUNCEMENT and ANNOUNCEMENT SETTING TRIGGERS TO INSERT INTO COMMON TABLE
         do {

            try db.execute(sql: "CREATE TRIGGER InsertAnnouncementSettingTrigger AFTER INSERT ON \(TB_ANNOUNCEMENT_SETTING) BEGIN INSERT INTO \(TB_COMMON_CATEGORIES) (id,name,type,createdBy,description,status,feedback,path,favourite,displaydatetime,occurrence) SELECT new.announcementid,name,'CEO Message',createdBy,description,rstatus,feedback,path,favourite,new.displaydatetime,new.occurrence FROM \(TB_ANNOUNCEMENT) WHERE announcementid = new.announcementid;END;")
         } catch let error {
           print("InsertAnnouncementSettingTrigger CREATION ERROR: \(error.localizedDescription)")
         }
         do {
               try db.execute(sql: "CREATE TRIGGER UpdateAnnouncementTrigger AFTER UPDATE ON \(TB_ANNOUNCEMENT) BEGIN UPDATE \(TB_COMMON_CATEGORIES) SET favourite = new.favourite,status = new.rstatus,feedback = new.feedback WHERE id = new.announcementid AND type = 'CEO Message';END;")
            } catch let error {
              print("UpdateAnnouncementTrigger CREATION ERROR: \(error.localizedDescription)")
            }

        do {
               try db.execute(sql: "CREATE TRIGGER deleteAnnouncementTrigger AFTER DELETE ON \(TB_ANNOUNCEMENT) BEGIN DELETE FROM \(TB_COMMON_CATEGORIES) WHERE id = old.announcementid AND type = 'CEO Message';END;")
            } catch let error {
              print("DeleteAnnouncementTrigger CREATION ERROR: \(error.localizedDescription)")
            }
        
        
        
          // COMMON TABLE
                try db.alter(table: TB_COMMON_CATEGORIES) { t in
                  t.add(column: TBC_COMMON_CATEGORIES_CREATEBY, .text)
                  t.add(column: TBC_COMMON_CATEGORIES_DESCRIPTION, .text)

          }
          
        
       }
       catch let error {
        
        print("TABLE CREATION ERROR:\(error.localizedDescription)")
      }
  }
      
   func CreateTables(db:Database) {
    
     do {
      
      // COMMON TABLE
            try db.create(table: TB_COMMON_CATEGORIES,ifNotExists: true) { t in
            t.column(TBC_COMMON_CATEGORIES_ID,.integer).notNull()
            t.column(TBC_COMMON_CATEGORIES_NAME, .text).notNull()
            t.column(TBC_COMMON_CATEGORIES_TYPE, .text).notNull()
            t.column(TBC_COMMON_CATEGORIES_STATUS, .text)
            t.column(TBC_COMMON_CATEGORIES_FEEDBACK, .text)
            t.column(TBC_COMMON_CATEGORIES_SELECTED_OPTION_ID, .integer)
            t.column(TBC_COMMON_CATEGORIES_PATH, .text)
            t.column(TBC_COMMON_CATEGORIES_FAVOURITE, .boolean).notNull()
            t.column(TBC_COMMON_CATEGORIES_DISPLAY_DATETIME, .datetime).notNull()
            t.column(TBC_COMMON_CATEGORIES_OCCURRENCE, .integer)
            t.column(TBC_COMMON_CATEGORIES_SCHEDULE_TYPE, .text)
            t.column(TBC_COMMON_CATEGORIES_SCHEDULE_YEAR, .integer)

            }
      
      
      // ALERT TABLE
        try db.create(table: TB_ALERT,ifNotExists: true) { t in
        t.column(TBC_ALERT_ID,.integer).primaryKey(onConflict: .abort, autoincrement: false)
        t.column(TBC_ALERT_NAME, .text)
        t.column(TBC_ALERT_FEEDBACK, .text)
        t.column(TBC_ALERT_PATH, .text)
        t.column(TBC_ALERT_CREATION_DATE, .datetime)
        t.column(TBC_ALERT_MODIFICATION_DATE, .datetime)
        t.column(TBC_ALERT_STATE, .text)
        t.column(TBC_ALERT_STATUS, .text)
        t.column(TBC_ALERT_RSTATUS, .text)
        t.column(TBC_ALERT_BUSINESSID, .integer)
        t.column(TBC_ALERT_FAVOURITE, .boolean)

           }
      

      
      // ALERT SETTING TABLE
      try db.create(table: TB_ALERT_SETTING,ifNotExists: true) { t in
        t.column(TBC_ALERT_SETTING_ID,.integer).primaryKey(onConflict: .abort, autoincrement: false)
        t.column(TBC_ALERT_SETTING_ALERT_ID_FK, .integer).notNull().references(TB_ALERT, onDelete: .cascade, onUpdate: .cascade)
        t.column(TBC_ALERT_SETTING_STAY_TIME, .integer)
        t.column(TBC_ALERT_SETTING_NOTIFICATION_TYPE, .text)
        t.column(TBC_ALERT_SETTING_OCCURRENCE, .integer)
        t.column(TBC_ALERT_SETTING_LOCAL_OCCURRENCE, .integer)
        t.column(TBC_ALERT_SETTING_RECURRENCE, .integer)
        t.column(TBC_ALERT_SETTING_CREATION_DATE, .datetime)
        t.column(TBC_ALERT_SETTING_MODIFICATION_DATE, .datetime)
        t.column(TBC_ALERT_SETTING_DISPLAY_TIME, .datetime)
                  
        }
     
    
      
     }
     catch let error {
      
      print("TABLE CREATION ERROR:\(error.localizedDescription)")
    }
    
    
    
    
    //--------------------TRIGGERS--------------------//

    //ALERT and ALERT SETTING TRIGGERS TO INSERT INTO COMMON TABLE
    do {

       try db.execute(sql: "CREATE TRIGGER InsertAlertSettingTrigger AFTER INSERT ON \(TB_ALERT_SETTING) BEGIN INSERT INTO \(TB_COMMON_CATEGORIES) (id,name,type,status,feedback,path,favourite,displaydatetime,occurrence) SELECT new.alertid,name,'Alert',rstatus,feedback,path,favourite,new.displaydatetime,new.occurrence FROM \(TB_ALERT) WHERE alertid = new.alertid;END;")
    } catch let error {
      print("InsertAlertSettingTrigger CREATION ERROR: \(error.localizedDescription)")
    }
    do {
          try db.execute(sql: "CREATE TRIGGER UpdateAlertTrigger AFTER UPDATE ON \(TB_ALERT) BEGIN UPDATE \(TB_COMMON_CATEGORIES) SET favourite = new.favourite,status = new.rstatus,feedback = new.feedback WHERE id = new.alertid AND type = 'Alert';END;")
       } catch let error {
         print("UpdateAlertTrigger CREATION ERROR: \(error.localizedDescription)")
       }
    
    do {
          try db.execute(sql: "CREATE TRIGGER deleteAlertTrigger AFTER DELETE ON \(TB_ALERT) BEGIN DELETE FROM \(TB_COMMON_CATEGORIES) WHERE id = old.alertid AND type = 'Alert';END;")
       } catch let error {
         print("DeleteAlertTrigger CREATION ERROR: \(error.localizedDescription)")
       }
    
  }
}
