//
//  SingleRsvpResponseModel.swift
//  mvvm-demo
//
//  Created by Adeel Kiani on 22/01/2020.
//

import Foundation

// MARK: - RsvpResponseModel
struct SingleRsvpResponseModel:Decodable {
    let status, message: String?
    let errorCode, numberOfItems: Int?
    let payLoad: EventPayLoad?
    let jwt: String?
    let filter: Filter?
}
