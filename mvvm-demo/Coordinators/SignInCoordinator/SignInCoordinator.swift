//
//  SignInCoordinator.swift
//  MvvmRxSwift
//
//  Created by Adeel Kiani on 13/10/2019.
//  Copyright © 2019 Adeel Kiani. All rights reserved.
//

import Foundation
import RxSwift

protocol SignInCoordinatorDelegate {
  func NavigateToHome()

}

class SignInCoordinator :Coordinator,SignInCoordinatorDelegate {

  func Logout() {
    
    
  }
  
  private let disposeBag = DisposeBag()
  
  var navigationController: UINavigationController
  weak var appCoordinator: AppCoordinator!

  init(navigationController: UINavigationController) {
       self.navigationController = navigationController
   }
   
  
  func openViewController(data:Any?) {

    let viewModel = SignInViewModel(eventType:PublishSubject<SIGNIN_ACTIONS>())
    let viewController = SignInViewController(viewModel: viewModel)
    viewController.coordinator = self
    navigationController.pushViewController(viewController, animated: true)
    navigationController.viewControllers = [viewController]

  }

  
  func NavigateToHome() {
    
//    let coordinator = HomeCoordinator(navigationController: navigationController)
//    coordinator.openViewController(data: nil)
       
   }
}
