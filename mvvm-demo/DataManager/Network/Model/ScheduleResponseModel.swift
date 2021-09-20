//
//  ScheduleResponseModel.swift
//  mvvm-demo
//
//  Created by Adeel Kiani on 25/01/2020.
//

import Foundation

// MARK: - ScheduleResponseModel
struct ScheduleResponseModel:Decodable {
    let status, message: String?
    let errorCode, numberOfItems: Int?
    let payLoad: [PayLoad]?
    let jwt: String?
    let filter: Filter?
}

// MARK: - ScheduleResponseModel
struct SingleScheduleResponseModel:Decodable {
    let status, message: String?
    let errorCode, numberOfItems: Int?
    let payLoad: PayLoad?
    let jwt: String?
    let filter: Filter?
}

// MARK: - PayLoad
struct PayLoad:Decodable {
    let eventcalenderId: Int?
    let name: String?
    let summary:String?
    let type: String?
    let date, creationDate,startTime,modificationDate,endTime: Int64?
    let year: String?
    let user: User?
    let status: String?
    let folder: Folder?
    let location:String?
    let imagePath:String?
    let userFavourite: UserFavourite?

}

enum ScheduleType:String {
    case CHHOLIDAY = "choliday"
    case NSHOLIDAY = "ncholiday"
    case REGULAR = "regular"
    case TENTATIVE = "tentative"
}

// MARK: - UserFavourite
struct UserFavourite:Decodable {
    let userFavouriteId: Int?
    let user: User?
    let creationDate: Int?
}
