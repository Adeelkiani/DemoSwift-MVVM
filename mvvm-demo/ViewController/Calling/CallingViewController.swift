//
//  CallingViewController.swift
//  mvvm-demo
//
//  Created by Adeel Kiani on 31/12/2019.
//

import Foundation

import AVFoundation
import PushKit
import TwilioVoice
import UIKit
import UserNotifications
import UIKit


class CallingViewController: UIViewController {


    @IBOutlet weak var speakerContainer: UIView!
    @IBOutlet weak var muteContainer: UIView!
    @IBOutlet weak var muteIcon: UIImageView!
    @IBOutlet weak var speakerIcon: UIImageView!
    @IBOutlet weak var endCall: UIImageView!
    @IBOutlet weak var headerView: CustomHeaderMain!
    @IBOutlet weak var txtCallDuration: UILabel!
    @IBOutlet weak var txtUserNumber: UILabel!

    @IBOutlet weak var speakerLeftNSConstraint: NSLayoutConstraint!
    @IBOutlet weak var mutedRightNSConstraint: NSLayoutConstraint!
    @IBOutlet weak var endCallTopNSConstraint: NSLayoutConstraint!


    let delegate = UIApplication.shared.delegate as! AppDelegate
    var onSelectedRowClosure: ((_ row: Int, _ value: String) -> Void)?
    var isTypeOutgoing: Bool = true
    var seconds = 0
    var timer = Timer()

    var isCallInProgress: Bool = false {

        didSet {
            if isCallInProgress {
                headerView.backButton.isHidden = true
                startCallDuration()
                callInProgressConstraints()
                                //UIView.animate(withDuration: 1.0) {
                self.view.layoutIfNeeded()
                                //}

            }
            else {
                headerView.backButton.isHidden = true
                speakerContainer.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0.003921568627, blue: 0.003921568627, alpha: 0.1540828339)
                muteContainer.backgroundColor =  #colorLiteral(red: 0.003921568627, green: 0.003921568627, blue: 0.003921568627, alpha: 0.1540828339)
                txtCallDuration.text = "Calling..."
                speakerLeftNSConstraint.constant = -100
                mutedRightNSConstraint.constant = -100
                endCallTopNSConstraint.constant = 0
                speakerContainer.isHidden = true
                muteContainer.isHidden = true
                headerView.backButtonLeftNSConstraint.constant = -50
                resetCallDuration()
            }

        }
    }

    var isSpeakerOn: Bool = false {
        didSet {

          if self.isSpeakerOn {
                          self.speakerContainer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                          self.speakerIcon.image = #imageLiteral(resourceName: "speaker_black")
                      }
                      else {
                          self.speakerContainer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
                          self.speakerIcon.image = #imageLiteral(resourceName: "speaker_white")
                      }

            delegate.audioDevice.block = {
                kTVODefaultAVAudioSessionConfigurationBlock()
                do {
                    if self.isSpeakerOn {
                        try AVAudioSession.sharedInstance().overrideOutputAudioPort(.speaker)
                    }
                    else {
                        try AVAudioSession.sharedInstance().overrideOutputAudioPort(.none)

                    }
                }catch {
                    NSLog(error.localizedDescription)
                }
            }

            delegate.audioDevice.block()

        }
    }

  var isMuteOn: Bool = false {
      didSet {

          if isMuteOn {
              muteContainer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
              muteIcon.image = #imageLiteral(resourceName: "muted_black")

          }
          else {
              muteContainer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
              muteIcon.image = #imageLiteral(resourceName: "muted_white")
          }
          if let call = delegate.call {
              call.isMuted = isMuteOn
          } else {
              NSLog("No active call to be muted")
          }

      }
  }


    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //        Register Notification Observer
       
      NotificationCenter.default.addObserver(self, selector: #selector(onVoiceCallBackReceived(notification:)), name: NSNotification.Name.voiceCallBacksSubscribedName, object: nil)

        setupViews()

        if isTypeOutgoing {
            delegate.StartCall(outgoingValueParam: "Admin")
        }

    }
    deinit {
        // CallKit has an odd API contract where the developer must call invalidate or the CXProvider is leaked.
        delegate.callKitProvider?.invalidate()
        resetCallDuration()
        isCallInProgress = false

    }

    func startCallDuration() {


        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateCallDuration), userInfo: nil, repeats: true)
    }

    func resetCallDuration() {


        timer.invalidate()
        seconds = 0

    }

    @objc func UpdateCallDuration() {
        seconds = seconds + 1
        let _minutes = Int(seconds) / 60 % 60
        let _seconds = Int(seconds) % 60
        let formatedString = String(format:"%02i:%02i", _minutes, _seconds)
        txtCallDuration.text = formatedString
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.voiceCallBacksSubscribedName, object: nil)
    }

    private func setupViews(){


        //To hide navigationBar
        if let navigationController = self.navigationController {
            navigationController.navigationBar.isHidden = true
            navigationController.interactivePopGestureRecognizer?.isEnabled = false
        }

        if !isTypeOutgoing {

            txtUserNumber.text = "Adeel"
            isCallInProgress = true

        }
        else {
            txtUserNumber.text = "Admin"

            isCallInProgress = false
        }
        speakerContainer.layer.cornerRadius = speakerContainer.frame.width/2
        muteContainer.layer.cornerRadius = muteContainer.frame.width/2

        let speakerTapGesture = UITapGestureRecognizer(target: self, action:  #selector (self.onSpeakerTapped(_:)))

        let muteTapGesture = UITapGestureRecognizer(target: self, action:  #selector (self.onMuteTapped(_:)))

        let backButtonGesture = UITapGestureRecognizer(target: self, action:  #selector (self.onBackButtonTapped(_:)))

        let endCallGesture = UITapGestureRecognizer(target: self, action:  #selector (self.onEndCallTapped(_:)))

        speakerContainer.addGestureRecognizer(speakerTapGesture)
        muteContainer.addGestureRecognizer(muteTapGesture)
        headerView.backButton.addGestureRecognizer(backButtonGesture)
        endCall.addGestureRecognizer(endCallGesture)

    }

    @objc func onSpeakerTapped (_ sender:UITapGestureRecognizer){

        self.isSpeakerOn = isSpeakerOn ? false : true

    }
    @objc func onMuteTapped (_ sender:UITapGestureRecognizer){

        self.isMuteOn = isMuteOn ? false : true

    }
    @objc func onEndCallTapped (_ sender:UITapGestureRecognizer){

        if let _call = delegate.call {

            delegate.performEndCallAction(uuid: _call.uuid)

        }

        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        speakerContainer.isHidden = true

        

    }

    @objc func onBackButtonTapped (_ sender:UITapGestureRecognizer){

        dismiss(animated: true) {

        }

    }

  @objc func onVoiceCallBackReceived (notification:NSNotification) -> Void {

        guard let callBackType = notification.userInfo!["type"] as? VoiceEnum else { return }

        switch callBackType {

        case .RINGING:
            print("RINGING")
            break

        case .CONNECTED:
            isCallInProgress = true
            break

        case .RECONNECTING:

            break

        case .RECONNECTED:
            print("RECONNECTED")
            break


        case .PERMISSION_DENIED(let uuid, let handle):
            let alertController: UIAlertController = UIAlertController(title: "Voice Quick Start",
                                                                       message: "Microphone permission not granted",
                                                                       preferredStyle: .alert)

            let continueWithMic: UIAlertAction = UIAlertAction(title: "Continue without microphone",
                                                               style: .default,
                                                               handler: { (action) in
                                                                self.delegate.performStartCallAction(uuid: uuid, handle: handle)
            })
            alertController.addAction(continueWithMic)

            let goToSettings: UIAlertAction = UIAlertAction(title: "Settings",
                                                            style: .default,
                                                            handler: { (action) in
                                                              guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                                                                    return
                                                                }

                                                                if UIApplication.shared.canOpenURL(settingsUrl) {
                                                                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                                                                    })
                                                                }
            })
            alertController.addAction(goToSettings)

            let cancel: UIAlertAction = UIAlertAction(title: "Cancel",
                                                      style: .cancel,
                                                      handler: { (action) in

            })
            alertController.addAction(cancel)

            self.present(alertController, animated: true, completion: nil)

            break

        case .DISCONNECTED:

            isCallInProgress = false
            isSpeakerOn = false
            isMuteOn = false
            if let navigationController = self.navigationController {
                navigationController.popViewController(animated: true)
            } else {
                self.dismiss(animated: true, completion: nil)
            }

            break

        }

    }

    private func callInProgressConstraints(){

        speakerContainer.isHidden = false
        muteContainer.isHidden = false

        let centerX = self.view.frame.size.width/2
        speakerLeftNSConstraint.constant = centerX - ((speakerContainer.frame.size.width/2)+50)
        mutedRightNSConstraint.constant = centerX - ((muteContainer.frame.size.width/2)+50)
        endCallTopNSConstraint.constant = 50
        //        headerView.backButtonLeftNSConstraint.constant = 5

    }


}
extension NSNotification.Name{
    static let voiceCallBacksSubscribedName = NSNotification.Name("voiceCallBacks")
}
