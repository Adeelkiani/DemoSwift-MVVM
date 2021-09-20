//
//  JWTResponseModel.swift
//  mvvm-demo
//
//  Created by Adeel Kiani on 28/11/2019.
//

import Foundation

// MARK: - JWTResponseModel
struct JWTResponseModel:Codable {
    let iss, sub, name, userCode: String?
    let userId, businessId: Int?
    let email: String?
    let secRole: [SECRole]?
    let screenActionCode: [String]?
    let businessName: String?
    let lightModeLogo, darkModeLogo: String?
    let iat, exp: Int?
    let businessUrl: String?
    let ceoName: String?

}

// MARK: - SECRole
struct SECRole:Codable {
    let roleId: Int?
    let name, secRoleDescription: String?
    let modificationDate: Int64?
}

