//
//  AppCoordinator.swift
//  MvvmRxSwift
//
//  Created by Adeel Kiani on 13/10/2019.
//  Copyright © 2019 Adeel Kiani. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
import RxSwift

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
   
  ///If you want to pass data send Any type in parameter
  func openViewController(data:Any?)
  func Logout()
  
}
final class AppCoordinator: Coordinator {
  
    
  var navigationController: UINavigationController
  // MARK: - Properties
   private let window: UIWindow
  var onDialogListner: ((_ categoryType:CATEGORY_TYPE,_ data:[AnyHashable : Any]?,_ isSnoozePressed:Bool,_ isDismissed:Bool) -> Void)?

   // MARK: - Initializer
   init(navController: UINavigationController, window: UIWindow) {
     self.navigationController = navController
     self.window = window
      self.navigationController.configure()
   }
  
  func openViewController(data:Any?) {
      window.rootViewController = navigationController
      window.makeKeyAndVisible()
    
//      NavigateToSignIn()
    let isLoggedIn = UserDefaults.standard.bool(forKey: DEFAULT_KEY_IS_LOGGED_IN)
    if isLoggedIn {
//      NavigateToHome()
    } else {
      NavigateToSignIn()
    }
  }
  
  
  func popViewController() {
    navigationController.popViewController(animated: true)
  }
  
  
  func showAlert(title:String = "",message: String) {

       let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
       alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
       navigationController.present(alertController, animated: true, completion: nil)
    
   }
  
   func openCallViewController() {


     let storyboard = UIStoryboard(name: "Main", bundle: nil)
         if let controller = storyboard.instantiateViewController(withIdentifier: "callingVC") as? CallingViewController {

           controller.isTypeOutgoing = false
           navigationController.pushViewController(controller, animated: true)
       }



   }
  
  // MARK: - Navigation
  private func NavigateToSignIn() {

      let coordinator = SignInCoordinator(navigationController: navigationController)
      coordinator.appCoordinator = self //IF WE WANT ANYTHING FROM APP COORDINATOR PASS IT'S REFERENCE
      coordinator.openViewController(data: nil)
  }

  func Logout() {
    
    let coordinator = SignInCoordinator(navigationController: navigationController)
    coordinator.openViewController(data: nil)
    
  }
}

// MARK: - UINavigationController Extension
private extension UINavigationController {
    func configure() {
        navigationBar.isHidden = true
        interactivePopGestureRecognizer?.isEnabled = false

    }
}
