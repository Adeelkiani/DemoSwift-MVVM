//
//  NewsLetterResponseModel.swift
//  mvvm-demo
//
//  Created by Adeel Kiani on 23/01/2020.
//

import Foundation


// MARK: - NewsLetterResponseModel
struct NewsLetterResponseModel:Decodable {
    let status, message: String?
    let errorCode, numberOfItems: Int?
    let payLoad: [NewsLetterPayload]?
    let jwt: String?
    let filter: Filter?
}

// MARK: - PayLoad
struct NewsLetterPayload:Decodable {
    let name: String?
    let summary:String?
    let status: String?
    let creationDate, modificationDate:Int64?
    let newsletterId: Int?
    let folder: Folder?
    let feedback: String?
    let path: String?
    let state: String?
    let newsletterNotificationList: [NewsLetterNotificationList]?
    let newsletterSetting: NewsLetterSetting?
}

struct NewsLetterNotificationList:Decodable {
    let newsletternotificationId: Int?
    let state: String?
    let type: String?
    let favourite: Bool?
    let user: User?
}


// MARK: - AlertSetting
struct NewsLetterSetting:Decodable {
    let newslettersettingId, stayTime, occurrence, recurrence: Int?
    let creationDate,modificationDate, displayDateTime: Int64?
}

