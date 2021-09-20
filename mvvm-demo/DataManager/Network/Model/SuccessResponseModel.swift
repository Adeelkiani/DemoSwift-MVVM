//
//  SuccessResponseModel.swift
//  mvvm-demo
//
//  Created by Adeel Kiani on 10/01/2020.
//

import Foundation
struct SuccessResponseModel:Decodable {
    let status, message: String?
    let errorCode, numberOfItems: Int?
    let payLoad:String?
    let jwt: String?
    let filter: Filter?
}
