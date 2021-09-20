//
//  Actions.swift
//  MvvmRxSwift
//
//  Created by Adeel Kiani on 17/10/2019.
//  Copyright © 2019 Adeel Kiani. All rights reserved.
//

import Foundation


enum SIGNIN_ACTIONS{
  case IS_SIGNIN_ACTIVE(Bool)
  case onSuccess(isFirstTimeLoggedIn:String)
  case onError(errorMessage:String)
}

enum ONBOARDING_ACTIONS{
    case IS_NEXT_ACTIVE(Bool)
    case IS_CODE_VALIDATED(Bool)
    case onCodeSent(Bool)
    case onCodeVerified(Bool)
    case onError(errorMessage:String)
}
