//
//  AddPollResponseModel.swift
//  mvvm-demo
//
//  Created by Adeel Kiani on 13/05/2020.
//

import Foundation

// MARK: - AddPollResponseModel
struct AddPollResponseModel:Decodable {
    let status, message: String?
    let errorCode, numberOfItems: Int?
    let payLoad: [AddPollPayload]?
    let jwt: String?
    let filter: Filter?
}

// MARK: - PayLoad
struct AddPollPayload:Decodable {
    let eventOptionId: Int?
    let pollOption: PollOption?
    let userPoll:UserPoll?
    let count, totalCount:Int?
    let countPercentage: Double?
}
