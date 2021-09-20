//
//  AlertsResponseModel.swift
//  mvvm-demo
//
//  Created by Adeel Kiani on 23/12/2019.
//

import Foundation

// MARK: - AlertsResponseModel
struct AlertsResponseModel:Decodable {
    let status, message: String?
    let errorCode, numberOfItems: Int?
    let payLoad: [AlertPayload]?
    let jwt: String?
    let filter: Filter?
}

// MARK: - PayLoad
struct AlertPayload:Decodable {
    let name: String?
    let summary:String?
    let status: String?
    let creationDate, modificationDate:Int64?
    let alertId: Int?
    let folder: Folder?
    let feedback: String?
    let path: String?
    let state: String?
    let alertNotificationList: [AlertNotificationList]?
    let alertSetting: AlertSetting?
}

// MARK: - AlertNotificationList
struct AlertNotificationList:Decodable {
    let alertnotificationId: Int?
    let state: String?
    let type: String?
    let favourite: Bool?
    let user: User?
}


// MARK: - User
struct User:Decodable {
    let userId: Int?
   let name, userCode, mobileNumber, email: String?
   let businessCode: String?
   let role: Role?
   let grade: Grade?
   let location: Location?
   let department: Department?
   let userStatus: String?
   let modificationDate: Int?
   let userSecRole: [Role]?
   let decodedPassword: String?
   let screenActionCode: [String]?
}

// MARK: - Location
struct Location:Decodable {
    let locationID: Int?
    let city: City?
    let province: Province?
    let address: String?
    let business: Business?
    let status: String?
}

// MARK: - City
struct City:Decodable {
    let cityId: Int?
    let name, provinceCode, countryCode, status: String?
}

// MARK: - Province
struct Province:Decodable {
    let provinceId: Int?
    let provinceCode: String?
    let country: Country?
    let name, status: String?
}

// MARK: - AddedBy
struct AddedBy:Decodable {
    let userId: Int?
    let name: String?
    let userCode, mobileNumber, email, password: String?
    let role: Role?
    let userStatus: String?
    let modificationDate: Int?
}

// MARK: - Role
struct Role:Decodable {
    let roleId: Int?
    let name: String?
    let roleDescription: String?
    let modificationDate: Int?
}

// MARK: - Department
struct Department:Decodable {
    let name: String?
    let business: Business?
    let deptId: Int?
}

// MARK: - Business
struct Business:Decodable {
    let businessId: Int?
    let businessemail: String?
    let name: String?
    let lightModeLogoURL, darkModeLogoURL: String?
    let businessAddress: String?
    let contactNumber: String?
    let gmt: String?
    let currency: Currency?
    let taxRate: Int?
    let status: String?
    let businessCode: String?
}


// MARK: - Currency
struct Currency:Decodable {
    let currencyId: Int?
    let name: String?
    let symbol: String?
    let status: String?
    let country: Country?
}

// MARK: - Country
struct Country:Decodable {
    let countryId: Int?
    let countryCode: String?
    let name: String?
    let status: String?
    let creationDate: Int?
}


// MARK: - Grade
struct Grade:Decodable {
    let gradeId: Int?
    let name: String?
    let business: Business?
}

// MARK: - AlertSetting
struct AlertSetting:Decodable {
    let alertsettingId, stayTime, occurrence, recurrence: Int?
    let creationDate,modificationDate, displayDateTime: Int64?
}

// MARK: - Folder
struct Folder:Decodable {
    let folderId: Int?
    let folderPath: String?
    let folderName, folderType: String?
}
