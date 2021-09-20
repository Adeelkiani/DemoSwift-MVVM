//
//  SingleNewsLetterResponseModel.swift
//  mvvm-demo
//
//  Created by Adeel Kiani on 23/01/2020.
//

import Foundation

struct SingleNewsLetterResponseModel:Decodable {
    let status, message: String?
    let errorCode, numberOfItems: Int?
    let payLoad: NewsLetterPayload?
    let jwt: String?
    let filter: Filter?
}
