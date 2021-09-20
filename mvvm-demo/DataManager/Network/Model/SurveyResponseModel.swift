//
//  SurveyResponseModel.swift
//  mvvm-demo
//
//  Created by Adeel Kiani on 21/07/2020.
//


import Foundation

// MARK: - SurveyResponseModel
struct SurveyResponseModel:Decodable {
    let status, message: String?
    let errorCode, numberOfItems: Int?
    let payLoad: [SurveyPayload]?
    let jwt: String?
    let filter: Filter?
}

// MARK: - PayLoad
struct SurveyPayload:Decodable {
    let surveyId: Int?
    let name: String?
    let folder: Folder?
    let feedback: String?
    let summary:String?
    let path: String?
    let jsonPath: String?
    let creationDate, modificationDate: Int64?
    let status, state, audience: String?
    let isAnonymous: Bool?
    let surveyNotificationList: [SurveyNotificationList]?
    let surveySetting: SurveySetting?
}

// MARK: - SurveyNotificationList
struct SurveyNotificationList:Decodable {
    let surveynotificationId: Int?
    let state: String?
    let creationDate: Int?
    let type: String?
    let favourite: Bool?
    let surveyResult: SurveyResult?
}

// MARK: - SurveyResult
struct SurveyResult:Decodable {
    let surveyResultId: Int?
    let folder: Folder?
    let path: String?
    let jsonPath: String?
    let creationDate, modificationDate: Int64?
    let user: User?
}
// MARK: - SurveySetting
struct SurveySetting:Decodable {
    let surveysettingId, stayTime: Int?
    let notificationType: String?
    let occurrence, recurrence:Int?
    let creationDate, modificationDate: Int64?
    let displayDateTime: Int64?
}
