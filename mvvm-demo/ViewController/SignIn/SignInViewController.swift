//
//  SignInViewController.swift
//  mvvm-demo
//
//  Created by Adeel Kiani on 29/10/2019.
//

import UIKit
import RxSwift
import Material
import RxCocoa
import RxGesture
import ANLoader


class SignInViewController: UIViewController {

  
  var viewModel: SignInViewModel!
  var coordinator: SignInCoordinatorDelegate!
  let disposeBag = DisposeBag()
  var showPassword:Bool = false

  @IBOutlet weak var employeeId:TextField!
  @IBOutlet weak var employeeView:UIView!
  @IBOutlet weak var backView:UIView!

  @IBOutlet weak var password:TextField!
  @IBOutlet weak var backgroundViewImage: UIImageView!
  @IBOutlet weak var appIcon: UIImageView!
  @IBOutlet weak var passwordIcon: UIImageView!
  @IBOutlet weak var signInButton: UIButton!

  let delegate = UIApplication.shared.delegate as! AppDelegate

  convenience init(viewModel:SignInViewModel) {
  self.init()
  self.viewModel = viewModel
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//  backgroundViewImage.image = UIImage(named: "Asd")

    delegate.VoIPRegistration()
    setUpBindings()
    hideKeyboardWhenTappedAround(view: backView)
    disableButton()
    setupViews()
    
    
    viewModel.clearRecords()
    
    textFieldSettings(textField: employeeId, placeHolder: "Employee Code",textPadding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),hideUnderLine: false,placeHolderVerticalPadding: 0)
    textFieldSettings(textField: password, placeHolder: "Password",textPadding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 25
    ),hideUnderLine: false,placeHolderVerticalPadding: 0)
  
    }

  private func enableButton()  {
    signInButton.isEnabled = true
    signInButton.setTitleColor(UIColor.init(named: "Blue Text Dark Theme"), for: .normal)
  }
  private func disableButton() {
    signInButton.isEnabled = false
    signInButton.setTitleColor(UIColor.gray, for: .normal)
  }
  
  private func setupViews(){
    
    passwordIcon.image = UIImage(named: "hide-password")
    
  }
  
  
  private func setUpBindings() {

     employeeId.rx.text.orEmpty
      .bind(to: self.viewModel.employeeId)
                    .disposed(by: self.disposeBag)
    
      password.rx.text.orEmpty
                     .bind(to: self.viewModel.password)
                     .disposed(by: self.disposeBag)
    
    signInButton.rx.tap
         .bind{  [weak self]  in

          self?.showLoader(text: "Authenticating...",disableUserInteraction: true,showDimView: true)

          self?.viewModel.onSignInTapped(employeeCode: self?.employeeId.text?.trimmingCharacters(in: .whitespaces) ?? "",password: self?.password.text?.trimmingCharacters(in: .whitespaces) ?? "")
         }
       .disposed(by: self.disposeBag)


    passwordIcon.rx.anyGesture(.tap())
      .when(.recognized)
      .subscribe({ gesture in
        
        self.password.isSecureTextEntry = !self.password.isSecureTextEntry
        if self.password.isSecureTextEntry {
          self.passwordIcon.image = UIImage(named: "hide-password")
        } else {
          self.passwordIcon.image = UIImage(named: "show-password")
        }
      })
      .disposed(by: disposeBag)
    
    //ACTIONS
    viewModel.eventType
        .asObservable()
        .observeOn(MainScheduler.instance)
        .subscribe (
        onNext: { [weak self] result in
    
          switch result {
            
          case .onSuccess(let isFirstTimeLoggedIn):
           
            self?.hideLoader {

              self?.coordinator.NavigateToHome()
            
          }
          case .onError(let error):
            self?.hideLoader {
              self?.showAlert(message: error)
            }
          case .IS_SIGNIN_ACTIVE(let result):
    
            if result {
              self?.enableButton()
            } else {
            self?.disableButton()
          }
            
          }
      })
      .disposed(by: self.disposeBag)
  }
}
