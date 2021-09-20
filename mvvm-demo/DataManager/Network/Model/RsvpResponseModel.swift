//
//  RsvpResponseModel.swift
//  mvvm-demo
//
//  Created by Adeel Kiani on 20/01/2020.
//

// MARK: - RsvpResponseModel
struct RsvpResponseModel:Decodable {
    let status, message: String?
    let errorCode, numberOfItems: Int?
    let payLoad: [EventPayLoad]?
    let jwt: String?
    let filter: Filter?
}


// MARK: - PayLoad
struct EventPayLoad:Decodable {
    let eventId: Int?
    let name: String?
    let folder: Folder?
    let feedback: String?
    let path: String?
    let imagePath: String?
    let date,startTime,endTime:Int64?
    let creationDate,modificationDate: Int64?
    let status: String?
    let state: String?
    let audience: String?
    let type: String?
    let summary, question: String?
    let location:String?
    let enablePollUpdate: Bool?
    let pollOption: [UserPoll]?
    let eventOption: [EventOption]?
    let userPoll: UserPoll?
    let eventNotificationList: [EventNotificationList]?
    let eventSetting: EventSetting?
}


// MARK: - EventNotificationList
struct EventNotificationList:Decodable {
    let eventNotificationId: Int?
    let user: User?
    let state: String?
    let creationDate: Int?
    let type: String?
    let favourite: Bool?
}


// MARK: - EventOption
struct EventOption:Decodable {
    let eventOptionId: Int?
    let pollOption: UserPoll?
    let count, totalCount:Int?
    let countPercentage:Double?
}

// MARK: - UserPoll
struct UserPoll:Decodable {
    let pollOptionId: Int?
    let name: String?
    let description: String?
    let creationDate: Int?
    let type: String?
}

// MARK: - EventSetting
struct EventSetting:Decodable {
    let eventSettingId, stayTime: Int?
    let notificationType: String?
    let occurrence, recurrence:Int?
    let creationDate, modificationDate: Int64?
    let displayDateTime: Int64?
}
// MARK: - PollOption
struct PollOption:Decodable {
    let pollOptionId: Int?
    let name, description: String?
}
