//
//  AnnouncementResponsModel.swift
//  mvvm-demo
//
//  Created by Adeel Kiani on 26/03/2020.
//


import Foundation

// MARK: - AnnouncementResponseModel
struct AnnouncementResponseModel:Decodable {
    let status, message: String?
    let errorCode, numberOfItems: Int?
    let payLoad: [AnnouncementPayLoad]?
    let jwt: String?
    let filter: Filter?
}

// MARK: - AlertsResponseModel
struct SingleAnnouncementResponseModel:Decodable {
    let status, message: String?
    let errorCode, numberOfItems: Int?
    let payLoad: AnnouncementPayLoad?
    let jwt: String?
    let filter: Filter?
}

// MARK: - AnnouncementNotificationList
struct AnnouncementNotificationList:Decodable {
    let announcementnotificationId: Int?
    let announcement: AnnouncementPayLoad?
    let state: String?
    let creationDate: Int64?
    let type: String?
    let favourite: Bool?
}

// MARK: - PayLoad
struct AnnouncementPayLoad:Decodable{
    let announcementId: Int?
    let name: String?
    let creator: String?
    let summary:String?
    let description: String?
    let folder: Folder?
    let image: String?
    let creationDate, modificationDate: Int64?
    let status, state, audience: String?
    let announcementNotificationList: [AnnouncementNotificationList]?
    let announcementSetting: AnnouncementSetting?
    let path: String?

}

// MARK: - AnnouncementSetting
struct AnnouncementSetting:Decodable {
    let announcementsettingId, stayTime: Int?
    let notificationType: String?
    let occurrence, recurrence:Int?
    let creationDate, modificationDate: Int64?
    let displayDateTime: Int64?
}

