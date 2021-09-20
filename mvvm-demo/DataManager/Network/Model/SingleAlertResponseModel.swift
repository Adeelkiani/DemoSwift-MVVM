//
//  SingleAlertResponseModel.swift
//  mvvm-demo
//
//  Created by Adeel Kiani on 03/01/2020.
//

import Foundation
// MARK: - AlertsResponseModel
struct SingleAlertResponseModel:Decodable {
    let status, message: String?
    let errorCode, numberOfItems: Int?
    let payLoad: AlertPayload?
    let jwt: String?
    let filter: Filter?
}
