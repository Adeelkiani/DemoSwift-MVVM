//
//  AppDelegate.swift
//  mvvm-demo
//
//  Created by Adeel Kiani on 21/10/2019.
//  Copyright © 2019 Adeel Kiani. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import ANLoader
import GRDB
import RxSwift
import TwilioVoice
import CallKit
import AVFoundation
import PushKit
import PopupDialog
import Toast_Swift
import Firebase

enum VoiceEnum {
  case RINGING
  case CONNECTED
  case RECONNECTING
  case RECONNECTED
  case PERMISSION_DENIED(uuid:UUID,handle:String)
  case DISCONNECTED

}
var database: DatabaseQueue!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var appCoordinator: AppCoordinator?
  var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
  var popupDialog:PopupDialog?
  //USE THIS TO SHOW NEXT POPUP
  var pendingDialogsStack = DialogStack()
  
  //VIEWMODEL
    
  //-------VOIP-------//
  var deviceTokenString: String?

  fileprivate let baseURLString = "https://demo.com/certificate/twilio"
  let accessTokenEndpoint = "/accessToken.php"
  let twimlParamTo = "to"
  var accessToken:String?
  var identity = ""


  //-------CALLKIT-------//
  var callInvite: TVOCallInvite?
  var call: TVOCall?
  var callKitCompletionCallback: ((Bool)->Swift.Void?)? = nil
  let audioDevice: TVODefaultAudioDevice = TVODefaultAudioDevice()
  var outgoingValue:String?
  var callKitProvider: CXProvider?
  var callKitCallController: CXCallController?
  var userInitiatedDisconnect: Bool = false
  var incomingPushCompletionCallback: (()->Swift.Void?)? = nil
  

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    try! setupDatabase(application)
    callKitSetup()
    prepareWindow()
    setupDefaults()
    configureLoader()
    application.registerForRemoteNotifications()
    

    return true
  }
  
  //Configuring default settings for app and observing view model
  func setupDefaults(){
    
    FirebaseApp.configure()

    let popupStyle  =  PopupDialogDefaultView.appearance()
    popupStyle.titleFont = UIFont(name: "Avenir-Book", size: 25)!
    popupStyle.titleColor =  UIColor(darkThemedColor: .BLACK_WHITE_TEXT)
    popupStyle.backgroundColor = UIColor(darkThemedColor: .WHITE_GREY)
    
    let destructiveStyle  =  DestructiveButton.appearance()
    destructiveStyle.titleFont = UIFont(name: "Avenir-Book", size: 16)!
    destructiveStyle.buttonColor = UIColor(darkThemedColor: .WHITE_GREY)
    
    let defaultStyle  =  DefaultButton.appearance()
        defaultStyle.titleFont = UIFont(name: "Avenir-Book", size: 16)!
       defaultStyle.buttonColor = UIColor(darkThemedColor: .WHITE_GREY)

    
    var style = ToastStyle()
        style.backgroundColor = UIColor(darkThemedColor: .TOAST_BACKGROUND)!
        style.messageColor = UIColor(darkThemedColor: .TOAST_TEXT)!
        style.titleFont = UIFont(name: "Avenir-Light", size: 15)!
        style.cornerRadius = 5.0
        style.displayShadow = true  
        ToastManager.shared.style = style
        ToastManager.shared.isTapToDismissEnabled = true
        ToastManager.shared.isQueueEnabled = true
    
    IQKeyboardManager.shared.enable = true

       let center = UNUserNotificationCenter.current()
         center.delegate = self // Don't forgot to set delegate
    
         //To get permissions from user:
         let options: UNAuthorizationOptions = [.alert, .sound, .badge];
         center.requestAuthorization(options: options) {
             (granted, error) in
             if !granted {
                 print("Notification permissions not granted")
             }
         }
            
  }
  
  
  func configureLoader(iconColor:UIColor = .white,textColor:UIColor = .white,loaderBackgroundColor:UIColor = .darkGray){
    ANLoader.activityColor = iconColor
    ANLoader.activityTextColor = textColor
    ANLoader.activityBackgroundColor = loaderBackgroundColor
    ANLoader.activityTextFontName = UIFont.init(name: FONT_FAMILY_AVENIR_BOOK, size: CGFloat(TEXT_SIZE_MEDIUM))!
  }
  
   private func setupDatabase(_ application: UIApplication) throws {
        let databaseURL = try FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("db.sqlite")
     
       let dbQueue = try DatabaseQueue(path: databaseURL.path)
        database = dbQueue
        database.setupMemoryManagement(in: application)
     
     // Setup the database
       AppDatabase().setup(dbQueue)
        
    }

  
}

//NOTIFICATION SETUP
extension AppDelegate {
  
  func callKitSetup(){
    let configuration = CXProviderConfiguration(localizedName: "mvvm-demo")
     configuration.maximumCallGroups = 1
     configuration.supportedHandleTypes = [.phoneNumber]
     configuration.supportsVideo = false
     configuration.maximumCallsPerCallGroup = 1
    
     callKitProvider = CXProvider(configuration: configuration)
     callKitCallController = CXCallController()
     callKitProvider!.setDelegate(self as? CXProviderDelegate, queue: nil)


     TwilioVoice.audioDevice = audioDevice
    
//          checkRecordPermission { result in
//    
//            }
  }
  
  func registerBackgroundTask() {
         backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
             self?.endBackgroundTask()
         }
    assert(backgroundTask != UIBackgroundTaskIdentifier.invalid)
     }
     
     func endBackgroundTask() {
         print("Background task ended.")
         UIApplication.shared.endBackgroundTask(backgroundTask)
      backgroundTask = UIBackgroundTaskIdentifier.invalid
     }
  
  
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
  
    let deviceTokenString = deviceToken.hexString
    UserDefaults.standard.set(deviceTokenString, forKey: DEFAULT_KEY_DEVICE_TOKEN)
    print("DEVICE TOKEN: \(deviceTokenString)")
  }
  
  func application(_ application: UIApplication,
              didFailToRegisterForRemoteNotificationsWithError
                  error: Error) {
     // Try again later.
    print("Unable to register for remote notifications")
    
  }
}

extension AppDelegate {
  
    private func prepareWindow() {

      let window = UIWindow(frame: UIScreen.main.bounds)

      let navController = UINavigationController()
      let appCoordinator = AppCoordinator(navController: navController, window: window)
      self.appCoordinator = appCoordinator

      appCoordinator.openViewController(data: nil)
      
    }
 
}

//NOTIFICATION DELEGATES
extension AppDelegate: UNUserNotificationCenterDelegate
{
  
  //CALLED WHEN ACTION IS PERFORMED ON NOTIFICATION OR IT IS TAPPED
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)
  {

    let data = response.notification.request.content.userInfo
        

    
    // Perform the task associated with the action.
      switch response.actionIdentifier {
      case "SNOOZE_ACTION":

//          if let notificationType =  data[NOTIFICATION_KEY_NOTIFICATION_TYPE] as? String,let typeId =  data[NOTIFICATION_KEY_NOTIFICATION_TYPE_ID] as? Int,
//                let occurrence =  data[NOTIFICATION_KEY_OCCURRENCE] as? Int{
//
//
//        }

         break
        
      case "READ_ACTION":break
        
         break
        
      default:break
        
    }
       
    
      completionHandler()
  }
    
  
  //CALLED WHEN NOTIFICATION WILL BE SHOWN
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
  {

    let state  = UIApplication.shared.applicationState
    let userInfo = notification.request.content.userInfo
    

    switch state {
    case UIApplication.State.active:
      
      completionHandler([.sound, .alert])
      break
    case UIApplication.State.background:
    completionHandler([.sound, .alert])

    case UIApplication.State.inactive:
    completionHandler([.sound, .alert])
      
    default:
      completionHandler([.sound, .alert])
    }
  }
  
  
  //CALLED WHEN REMOTE NOTIFICATION WILL BE RECEIVED
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

    registerBackgroundTask()

    
    let state  = application.applicationState
    switch state {
    case UIApplication.State.active:
      ShowRemoteNotification(userInfo: userInfo, isForground: true)
    case UIApplication.State.background:
      
      ShowRemoteNotification(userInfo: userInfo, isForground: false)
      
    case UIApplication.State.inactive:
      ShowRemoteNotification(userInfo: userInfo, isForground: false)
      
    default:
      ShowRemoteNotification(userInfo: userInfo, isForground: false)
    }
    
    completionHandler(UIBackgroundFetchResult.newData)
  }
  
  ///Handle data from incoming Remote/PushKit Notification
  func ShowRemoteNotification(userInfo: [AnyHashable: Any], isForground: Bool) {
  
  
    if let notificationType = userInfo[AnyHashable(NOTIFICATION_KEY_NOTIFICATION_TYPE)] as? String{
      
      print("NOTIFICATION RECEIVED \(notificationType)")

//     ShowNotification(title: "TYPE: \(notificationType)")

//      if notificationType.caseInsensitiveCompare(NOTIFICATION_TYPES.ANNOUNCEMENT.rawValue) == .orderedSame {
//
//        }
    
  }

 
  
  //TEST DEMO NOTIFICATION
  func ShowNotification(title:String) {
    
    // Create Notification Content
    let notificationContent = UNMutableNotificationContent()

    // Configure Notification Content
    notificationContent.title = title
    notificationContent.subtitle = "Test notificatin"
    notificationContent.body = "Test notification"

    // Add Trigger
    let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1.0, repeats: false)

    // Create Notification Request
    let notificationRequest = UNNotificationRequest(identifier: "cocoacasts_local_notification", content: notificationContent, trigger: notificationTrigger)

    // Add Request to User Notification Center
    UNUserNotificationCenter.current().add(notificationRequest) { (error) in
      if let error = error {
        print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
      }

    }

  }
}

}

//-----------VOICE ACTIONS-----------//
extension AppDelegate {

  func StartCall(outgoingValueParam:String){
    self.outgoingValue = outgoingValueParam
    if let _outgoingValue = self.outgoingValue {


      if (self.call != nil && self.call?.state == .connected) {
        self.userInitiatedDisconnect = true
        performEndCallAction(uuid: self.call!.uuid)
      } else {
        let uuid = UUID()
        let handle = _outgoingValue

        self.checkRecordPermission { (permissionGranted) in
          if (!permissionGranted) {
            self.sendVoiceCallBack(type: VoiceEnum.PERMISSION_DENIED(uuid: uuid, handle: handle))
          } else {
            self.performStartCallAction(uuid: uuid, handle: handle)
          }
        }
      }
    }

  }

  func checkRecordPermission(completion: @escaping (_ permissionGranted: Bool) -> Void) {
    let permissionStatus: AVAudioSession.RecordPermission = AVAudioSession.sharedInstance().recordPermission

    switch permissionStatus {
    case AVAudioSession.RecordPermission.granted:
      // Record permission already granted.
      completion(true)
      break
    case AVAudioSession.RecordPermission.denied:
      // Record permission denied.
      completion(false)
      break
    case AVAudioSession.RecordPermission.undetermined:
      // Requesting record permission.
      // Optional: pop up app dialog to let the users know if they want to request.
      AVAudioSession.sharedInstance().requestRecordPermission({ (granted) in
        completion(granted)
      })
      break
    default:
      completion(false)
      break
    }
  }

  func incomingPushHandled() {
    if let completion = self.incomingPushCompletionCallback {
      completion()
      self.incomingPushCompletionCallback = nil
    }
  }



  func callDisconnected() {
    self.call = nil
    self.callKitCompletionCallback = nil
    self.userInitiatedDisconnect = false

    sendVoiceCallBack(type: VoiceEnum.DISCONNECTED)


  }

  func sendVoiceCallBack(type:VoiceEnum) {

    NotificationCenter.default.post(name: NSNotification.Name.voiceCallBacksSubscribedName, object: nil, userInfo: ["type":type])
  }

  
  func fetchAccessToken() -> String? {
    let endpointWithIdentity = String(format: "%@?identity=%@", accessTokenEndpoint, identity)

    guard let accessTokenURL = URL(string: baseURLString + endpointWithIdentity) else {
      return nil
    }
    
    print("ACCESS TOKEN URL: \(accessTokenURL)")
    
    accessToken = try? String.init(contentsOf: accessTokenURL, encoding: .utf8)
    return try? String.init(contentsOf: accessTokenURL, encoding: .utf8)
  }


  // MARK: Call Kit Actions
  func performStartCallAction(uuid: UUID, handle: String) {
    let callHandle = CXHandle(type: .generic, value: handle)
    let startCallAction = CXStartCallAction(call: uuid, handle: callHandle)
    let transaction = CXTransaction(action: startCallAction)

    callKitCallController!.request(transaction)  { error in
      if let error = error {
        NSLog("StartCallAction transaction request failed: \(error.localizedDescription)")
        return
      }

      NSLog("StartCallAction transaction request successful")

      let callUpdate = CXCallUpdate()
      callUpdate.remoteHandle = callHandle
      callUpdate.supportsDTMF = true
      callUpdate.supportsHolding = true
      callUpdate.supportsGrouping = false
      callUpdate.supportsUngrouping = false
      callUpdate.hasVideo = false

      self.callKitProvider!.reportCall(with: uuid, updated: callUpdate)
    }
  }

  func reportIncomingCall(from: String, uuid: UUID) {
    let callHandle = CXHandle(type: .generic, value: from)

    let callUpdate = CXCallUpdate()
    callUpdate.remoteHandle = callHandle
    callUpdate.supportsDTMF = true
    callUpdate.supportsHolding = true
    callUpdate.supportsGrouping = false
    callUpdate.supportsUngrouping = false
    callUpdate.hasVideo = false

    callKitProvider!.reportNewIncomingCall(with: uuid, update: callUpdate) { error in
      if let error = error {
        NSLog("Failed to report incoming call successfully: \(error.localizedDescription).")
      } else {
        NSLog("Incoming call successfully reported.")
      }
    }
  }

  func performEndCallAction(uuid: UUID) {

    let endCallAction = CXEndCallAction(call: uuid)
    let transaction = CXTransaction(action: endCallAction)

    callKitCallController!.request(transaction) { error in
      if let error = error {
        NSLog("EndCallAction transaction request failed: \(error.localizedDescription).")
      } else {
        NSLog("EndCallAction transaction request successful")
      }
    }
  }
  func performVoiceCall(uuid: UUID, client: String?, completionHandler: @escaping (Bool) -> Swift.Void) {
    guard let accessToken = fetchAccessToken() else {
      completionHandler(false)
      return
    }
    

    let connectOptions: TVOConnectOptions = TVOConnectOptions(accessToken: accessToken) { (builder) in
      builder.params = [self.twimlParamTo : client!]
      builder.uuid = uuid
    }
    call = TwilioVoice.connect(with: connectOptions, delegate: self)
    self.callKitCompletionCallback = completionHandler
  }

  func performAnswerVoiceCall(uuid: UUID, completionHandler: @escaping (Bool) -> Swift.Void) {
    let acceptOptions: TVOAcceptOptions = TVOAcceptOptions(callInvite: self.callInvite!) { (builder) in
      builder.uuid = self.callInvite?.uuid
    }
    call = self.callInvite?.accept(with: acceptOptions, delegate: self)
    self.callInvite = nil
    self.callKitCompletionCallback = completionHandler
    self.incomingPushHandled()
  }

}
  

//-----------PUSH KIT-----------//
@available(iOS 10, *)
extension AppDelegate : PKPushRegistryDelegate {

  func VoIPRegistration() {

    let mainQueue = DispatchQueue.main

    let voipRegistry:PKPushRegistry = PKPushRegistry(queue: mainQueue)

    voipRegistry.delegate = self
    voipRegistry.desiredPushTypes = [PKPushType.voIP]
  }

  func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {

    print("VOIP TOKEN: \(pushCredentials.token.map { String(format: "%02.2hhx", $0) }.joined())")

    if (type != .voIP) {
      return
    }

    let deviceToken = pushCredentials.token.map { String(format: "%02.2hhx", $0) }.joined()
    UserDefaults.standard.set(deviceToken, forKey: DEFAULT_KEY_VOIP_TOKEN)
    
      
//    viewModel.getTwillioAccessToken(url: "\(baseURLString + accessTokenEndpoint)?identity=\(identity)") { _accessToken in
//    
//    if let token = _accessToken {
//    self.accessToken = token
//      
//    let deviceToken = pushCredentials.token.map { String(format: "%02.2hhx", $0) }.joined()
//    UserDefaults.standard.set(deviceToken, forKey: DEFAULT_KEY_VOIP_TOKEN)
//    
//    TwilioVoice.register(withAccessToken: token, deviceToken: deviceToken) { (error) in
//      if let error = error {
//        NSLog("An error occurred while registering: \(error.localizedDescription)")
//      }
//      else {
//        NSLog("Successfully registered for VoIP push notifications.")
//          }
//        }
//      }
//    }

    self.deviceTokenString = deviceToken

  }


  func pushRegistry(_ registry: PKPushRegistry, didInvalidatePushTokenFor type: PKPushType) {
    NSLog("pushRegistry:didInvalidatePushTokenForType:")

    if (type != .voIP) {
      return
    }

     let deviceToken = deviceTokenString ?? ""

    
//    let endpointWithIdentity = String(format: "%@?identity=%@", accessTokenEndpoint, identity)

      
//    viewModel.getTwillioAccessToken(url: "\(baseURLString)?identity=\(identity)") { _accessToken in
//
//    if let token = _accessToken {
//    self.accessToken = token
//
//    TwilioVoice.register(withAccessToken: token, deviceToken: deviceToken) { (error) in
//      if let error = error {
//        NSLog("An error occurred while registering: \(error.localizedDescription)")
//      }
//      else {
//        NSLog("Successfully registered for VoIP push notifications.")
//          }
//        }
//      }
//    }
    
    
    self.deviceTokenString = nil
  }



  /**
   * This delegate method is available on iOS 11 and above. Call the completion handler once the
   * notification payload is passed to the `TwilioVoice.handleNotification()` method.
   */
  func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
    NSLog("pushRegistry:didReceiveIncomingPushWithPayload:forType:completion:")
    // Save for later when the notification is properly handled.

//    ShowNotification(title: "TESTING MY VOIP")


    if (type == PKPushType.voIP && payload.dictionaryPayload["twi_from"] != nil) {
      TwilioVoice.handleNotification(payload.dictionaryPayload, delegate: self)
    } else {

      let state = UIApplication.shared.applicationState
      switch state {
      case UIApplication.State.active:
        ShowRemoteNotification(userInfo: payload.dictionaryPayload, isForground: true)
      case UIApplication.State.background:
        ShowRemoteNotification(userInfo: payload.dictionaryPayload, isForground: false)
      case UIApplication.State.inactive:
        ShowRemoteNotification(userInfo: payload.dictionaryPayload, isForground: false)
      default:
        ShowRemoteNotification(userInfo: payload.dictionaryPayload, isForground: false)
      }

    }
  }
}

//-----------------CALL KIT AND TWILIO-----------------//
extension AppDelegate: TVONotificationDelegate, TVOCallDelegate, CXProviderDelegate {

  // MARK: TVONotificaitonDelegate
  func callInviteReceived(_ callInvite: TVOCallInvite) {
    NSLog("callInviteReceived:")

    if (self.callInvite != nil) {
      NSLog("A CallInvite is already in progress. Ignoring the incoming CallInvite from \(String(describing: callInvite.from))")
      self.incomingPushHandled()
      return;
    } else if (self.call != nil) {
      NSLog("Already an active call.");
      NSLog("  >> Ignoring call from \(String(describing: callInvite.from))");
      self.incomingPushHandled()
      return;
    }

    self.callInvite = callInvite


    self.reportIncomingCall(from: "Adeel", uuid: callInvite.uuid)


  }


  func cancelledCallInviteReceived(_ cancelledCallInvite: TVOCancelledCallInvite) {
      NSLog("cancelledCallInviteCanceled:")
      
      self.incomingPushHandled()
      
      if (self.callInvite == nil ||
          self.callInvite!.callSid != cancelledCallInvite.callSid) {
          NSLog("No matching pending CallInvite. Ignoring the Cancelled CallInvite")

          if #available(iOS 13.0, *) {
              // Ignoring the cancel when CallKit has a Call in progreass.
              if (self.call?.state != TVOCallState.disconnected) {
                  return;
              }

              // iOS 13 workaround
//              let uuid = UUID()
              self.reportIncomingCall(from: "Adeel", uuid: callInvite!.uuid)

              DispatchQueue.main.async {
                  self.performEndCallAction(uuid: self.callInvite!.uuid)
              }
          }
          return
      }
      
      performEndCallAction(uuid: self.callInvite!.uuid)

      self.callInvite = nil
      self.incomingPushHandled()
  }

  // MARK: TVOCallDelegate
  func callDidStartRinging(_ call: TVOCall) {
    NSLog("callDidStartRinging:")
    sendVoiceCallBack(type: VoiceEnum.RINGING)
    //                self.placeCallButton.setTitle("Ringing", for: .normal)
  }
  
  func callDidConnect(_ call: TVOCall) {
    NSLog("callDidConnect:")

    self.call = call
    self.callKitCompletionCallback!(true)
    self.callKitCompletionCallback = nil
    sendVoiceCallBack(type: VoiceEnum.CONNECTED)
  }


  func call(_ call: TVOCall, isReconnectingWithError error: Error) {
    NSLog("call:isReconnectingWithError:")

    sendVoiceCallBack(type: VoiceEnum.RECONNECTING)

  }

  func callDidReconnect(_ call: TVOCall) {
    NSLog("callDidReconnect:")

    sendVoiceCallBack(type: VoiceEnum.RECONNECTED)
    //        isCallInProgress = true

  }

  func call(_ call: TVOCall, didFailToConnectWithError error: Error) {
    NSLog("Call failed to connect: \(error.localizedDescription)")

    if let completion = self.callKitCompletionCallback {
      completion(false)
    }

    performEndCallAction(uuid: call.uuid)
    callDisconnected()
  }

  func call(_ call: TVOCall, didDisconnectWithError error: Error?) {
    if let error = error {
      NSLog("Call failed: \(error.localizedDescription)")
    } else {
      NSLog("Call disconnected")
    }

    if !self.userInitiatedDisconnect {
      var reason = CXCallEndedReason.remoteEnded

      if error != nil {
        reason = .failed
      }

      self.callKitProvider!.reportCall(with: call.uuid, endedAt: Date(), reason: reason)
    }

    callDisconnected()
  }

  // MARK: CXProviderDelegate
  func providerDidReset(_ provider: CXProvider) {
    NSLog("providerDidReset:")
    audioDevice.isEnabled = true
  }

  func providerDidBegin(_ provider: CXProvider) {
    NSLog("providerDidBegin")
  }

  func provider(_ provider: CXProvider, didActivate audioSession: AVAudioSession) {
    NSLog("provider:didActivateAudioSession:")
    audioDevice.isEnabled = true
  }

  func provider(_ provider: CXProvider, didDeactivate audioSession: AVAudioSession) {
    NSLog("provider:didDeactivateAudioSession:")
  }

  func provider(_ provider: CXProvider, timedOutPerforming action: CXAction) {
    NSLog("provider:timedOutPerformingAction:")
  }

  func provider(_ provider: CXProvider, perform action: CXStartCallAction) {
    NSLog("provider:performStartCallAction:")


    audioDevice.isEnabled = false
    audioDevice.block();

    provider.reportOutgoingCall(with: action.callUUID, startedConnectingAt: Date())

    if let _outGoingValue = outgoingValue {
      self.performVoiceCall(uuid: action.callUUID, client: _outGoingValue) { (success) in
        if (success) {
          provider.reportOutgoingCall(with: action.callUUID, connectedAt: Date())
          action.fulfill()
        } else {
          action.fail()
        }
      }
    }
  }

  func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
    NSLog("provider:performAnswerCallAction:")


    assert(action.callUUID == self.callInvite?.uuid)

    audioDevice.isEnabled = false
    audioDevice.block();

    self.performAnswerVoiceCall(uuid: action.callUUID) { (success) in
      if (success) {

     
        self.appCoordinator?.openCallViewController()

        action.fulfill()


      } else {
        action.fail()
      }
    }

    action.fulfill()


  }

  func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
    NSLog("provider:performEndCallAction:")

    if (self.callInvite != nil) {
      self.callInvite!.reject()
      self.callInvite = nil
    } else if (self.call != nil) {
      self.call?.disconnect()
    }

    audioDevice.isEnabled = true
    action.fulfill()
  }

  func provider(_ provider: CXProvider, perform action: CXSetHeldCallAction) {
    NSLog("provider:performSetHeldAction:")
    if (self.call?.state == .connected) {
      self.call?.isOnHold = action.isOnHold
      action.fulfill()
    } else {
      action.fail()
    }
  }
}
