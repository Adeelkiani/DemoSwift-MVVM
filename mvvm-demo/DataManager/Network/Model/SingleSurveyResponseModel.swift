//
//  SingleSurveyResponseModel.swift
//  mvvm-demo
//
//  Created by Adeel Kiani on 23/07/2020.
//

import Foundation

struct SingleSurveyResponseModel:Decodable {
    let status, message: String?
    let errorCode, numberOfItems: Int?
    let payLoad: SurveyPayload?
    let jwt: String?
    let filter: Filter?
}

// MARK: - SubmitSurveyResponseModel
struct SubmitSurveyResponseModel:Decodable {
    let status, message: String?
    let errorCode, numberOfItems: Int?
    let payLoad: SurveyResult?
    let jwt: String?
    let filter: Filter?
}
