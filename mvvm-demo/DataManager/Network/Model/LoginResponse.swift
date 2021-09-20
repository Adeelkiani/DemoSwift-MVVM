//
//  LoginResponse.swift
//  mvvm-demo
//
//  Created by Adeel Kiani on 26/11/2019.
//

import Foundation
struct LoginResponse:Decodable {
    let status, message: String?
    let errorCode, numberOfItems, payLoad: Int?
    let jwt: String?
    let filter: Filter?
}
// MARK: - Filter
struct Filter:Decodable {
    let defaultFilter: String?
}
