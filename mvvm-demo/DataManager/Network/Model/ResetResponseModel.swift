//
//  ResetResponseModel.swift
//  mvvm-demo
//
//  Created by Adeel Kiani on 20/03/2020.
//

import Foundation

// MARK: - ResetResponseModel
struct ResetResponseModel:Decodable {
    let status, message: String?
    let errorCode, numberOfItems: Int?
    let payLoad: User?
    let jwt: String?
    let filter: Filter?
}

