//
//  Extensions.swift
//  MvvmRxSwift
//
//  Created by Adeel Kiani on 15/10/2019.
//  Copyright © 2019 Adeel Kiani. All rights reserved.
//

import UIKit
import Material
import ANLoader

extension UIViewController {
  
  func hideKeyboardWhenTappedAround(view:UIView) {
     let tap: UITapGestureRecognizer = UITapGestureRecognizer(target:self,action:#selector(hideKeyBoard))
     tap.cancelsTouchesInView = false
     view.addGestureRecognizer(tap)
   }
  
  @objc func hideKeyBoard() {
    view.endEditing(true)
  }
  

  //MATERIAL TEXT FIELD SETUP
   func textFieldSettings(textField: TextField, placeHolder: String, text: String = "",textPadding:EdgeInsets = EdgeInsets.zero,hideUnderLine:Bool = true,placeHolderVerticalPadding:CGFloat = 0,placeHolderHorizontalPadding:CGFloat = 0) {
     
     textField.placeholder = placeHolder
     textField.clearButtonMode = .whileEditing
     textField.text = text
     textField.textColor = UIColor(darkThemedColor: .BLACK_WHITE_TEXT)
     textField.placeholderVerticalOffset = placeHolderVerticalPadding
     textField.placeholderHorizontalOffset = placeHolderHorizontalPadding
     textField.isDividerHidden = hideUnderLine
      textField.dividerActiveColor = UIColor(darkThemedColor: .PLACE_HOLDER_ACTIVE) ?? UIColor.black
    textField.dividerNormalColor = UIColor(darkThemedColor: .PLACE_HOLDER_NORMAL) ?? UIColor.darkGray
     textField.placeholderActiveColor = UIColor(darkThemedColor: .PLACE_HOLDER_ACTIVE) ?? UIColor.black
     textField.placeholderNormalColor = UIColor(darkThemedColor: .PLACE_HOLDER_NORMAL) ?? UIColor.darkGray

    textField.textInsets = textPadding
  }

  func showAlert(title:String = "",message: String) {

       let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
       alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
       self.present(alertController, animated: true, completion: nil)
    
   }

  func showAlertWithCallBack(title:String = "",message: String,completionHandler: @escaping ()->()) {

    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
        completionHandler()
        
       }))
      self.present(alertController, animated: true, completion: nil)
   
  }
  
  func showConfirmationAlert(title:String = "",message: String,completionHandler: @escaping (_ isConfirmed:Bool)->()) {

       let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
       alertController.addAction(UIAlertAction(title: "CANCEL", style: .default, handler: { _ in
        completionHandler(false)
        
       }))
    alertController.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { _ in
         completionHandler(true)
         
        }))
       self.present(alertController, animated: true, completion: nil)
    
   }
  
  func showLoader(text:String,disableUserInteraction:Bool = false,showDimView:Bool = false){
    ANLoader.viewBackgroundDark = showDimView
    ANLoader.showLoading(text, disableUI: disableUserInteraction)
  }
  
  func hideLoader(delay:DispatchTime = .now() + 0.5,onLoaderHidden:@escaping ()->()){
    
    DispatchQueue.main.asyncAfter(deadline:delay) {

      ANLoader.hide()
      onLoaderHidden()
    }
  }
 
      var isVisibleToUser: Bool {

          let presentingIsModal = presentingViewController != nil
          let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
          let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController

          return presentingIsModal || presentingIsNavigation || presentingIsTabBar
      }
  
  
  class AlwaysPresentAsPopover : NSObject, UIPopoverPresentationControllerDelegate {

    // `sharedInstance` because the delegate property is weak - the delegate instance needs to be retained.
    private static let sharedInstance = AlwaysPresentAsPopover()

    private override init() {
      super.init()
    }

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
      return .none
    }

    static func configurePresentation(forController controller : UIViewController) -> UIPopoverPresentationController {
      controller.modalPresentationStyle = .popover
      let presentationController = controller.presentationController as! UIPopoverPresentationController
      presentationController.delegate = AlwaysPresentAsPopover.sharedInstance
      return presentationController
    }
  }

  
  ///Call this function on Main Thread
  func getLabelHeight(_ textView: UILabel)->CGFloat{
    
      
      let fixedWidth = textView.frame.size.width
    textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
    let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
      var newFrame = textView.frame
      newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
          
      return newFrame.size.height
  }
}


enum ICON_DIRECION {
  case LEFT
  case RIGHT
  case NONE
}
extension UITextField {
  func setIcon(_ image: UIImage,iconDirection:ICON_DIRECION,containerView:UIView?) {
   let iconView = UIImageView(frame:
                  CGRect(x: 10, y: 5, width: 20, height: 20))
   iconView.image = image
  
    
    if iconDirection == .LEFT {
      if let view =  containerView {
        leftView = view
      } else {
        
        let iconContainerView: UIView = UIView(frame:CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
      }
      leftViewMode = .always

    } else {
      
      if let view =  containerView {
        rightView = view
      } else {
        
          let iconContainerView: UIView = UIView(frame:CGRect(x: -20, y: 0, width: 30, height: 30))
          iconContainerView.addSubview(iconView)
          leftView = iconContainerView

        }
      rightViewMode = .always

    }
    
}

  
}
extension String {
    mutating func add(prefix: String) {
        self = prefix + self
    }
}

extension UIImageView {
  
  //ROTATE IMAGE
  func rotate(degrees: CGFloat) {

         let degreesToRadians: (CGFloat) -> CGFloat = { (degrees: CGFloat) in
             return degrees / 180.0 * CGFloat.pi
         }
         self.transform =  CGAffineTransform(rotationAngle: degreesToRadians(degrees))

     }

  func load(url: URL,onResult:@escaping (_ isLoaded:Bool)->()) {
    DispatchQueue.global(qos: .background).async{ [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                  
                    DispatchQueue.main.async {
                        self?.image = image
                      onResult(true)
                    }
                } else {
                  DispatchQueue.main.async {
                  onResult(false)
                  }
              }
            } else {
              DispatchQueue.main.async {
              onResult(false)
              }
          }
        }
    }
  
  func load(url: URL,onResult:@escaping (_ isLoaded:Bool,_ data:Data?)->()) {
    DispatchQueue.global(qos: .background).async{ [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                  
                    DispatchQueue.main.async {
                        self?.image = image
                      onResult(true,data)
                    }
                } else {
                  DispatchQueue.main.async {
                  onResult(false,nil)
                  }
              }
            } else {
              DispatchQueue.main.async {
              onResult(false,nil)
              }
          }
        }
    }
  
  func pv_heightForImageView() -> CGFloat {
       guard let image = image, image.size.height > 0 else {
           return 0.0
       }
       let width = bounds.size.width
       let ratio = image.size.height / image.size.width
       return width * ratio
   }
  
}

extension UIImage {

    func imageResize (sizeChange:CGSize)-> UIImage{

        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen

        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))

        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage!
    }

}

extension Collection where Indices.Iterator.Element == Index {
  
  //FOR HANDLING INDEX OUR OF BOUND ERROR
  subscript (safe index: Index) -> Iterator.Element? {
    return indices.contains(index) ? self[index] : nil
  }
}

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
  
  ///Returns string date in yyyy-MM-dd HH:mm:ss format
  func UTCToLocalDate(date: String) -> String {
         let formatter = DateFormatter()
         //        formatter.dateFormat = "H:mm:ss"
         formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
         formatter.timeZone = TimeZone(abbreviation: "UTC")
         
         let dt = formatter.date(from: date)
         formatter.timeZone = TimeZone.current
         formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
         
         return formatter.string(from: dt!)
     }

  
  func formatDateTo(date: DATE_FORMATES) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let stringDate = formatter.string(from: self)
        let dt = formatter.date(from: stringDate)
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "\(date.rawValue)"
        
        return formatter.string(from: dt!)
    }
  
  var dateToDateComponent:DateComponents {
    
    let calendar = Calendar.current

    let year = calendar.component(.year, from: self)
    let month = calendar.component(.month, from: self)
    let day = calendar.component(.day, from: self)
    let hour = calendar.component(.hour, from: self)
    let minute = calendar.component(.minute, from: self)
//    print("DATE: year:\(year) month:\(month) day:\(day) hour:\(hour) minute:\(minute)")

    return DateComponents(calendar: Calendar.current, year: year, month: month, day: day, hour: hour, minute:minute)
  }
}

extension Int64 {
  
  var millisecondsToDate:Date {
    return Date(timeIntervalSince1970: (Double(self) / 1000.0))
     }
}

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
  func deletingsuffix(_ suffix: String) -> String {
    guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }

  
  func heightForLabel(font:UIFont,view:UIView) -> CGFloat {
    let messageText = self.lowercased().trimmed
    let size = CGSize(width: view.frame.width - 100, height: .infinity)
    let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
    let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : font], context: nil)
    
    return estimatedFrame.height
  }

  func getMillisecondsFromStringDate(dateFormat:DATE_FORMATES)->Int64 {
    
        let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat.rawValue
        let date = dateFormatter.date(from: self)
        
    return date?.millisecondsSince1970 ?? 0
    
  }
 }

extension UILabel {
    ///Change certain word or text color in string
  func changeWordColor (fullText : String , changeText : String ,color:UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(.foregroundColor, value: color , range: range)
        attribute.addAttribute(.font, value: UIFont.italicSystemFont(ofSize: 12), range: range)
        self.attributedText = attribute
    }
  
  func changeDefaultWordColor (fullText : String , changeText : String ,color:UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),font:UIFont) {
         let strNumber: NSString = fullText as NSString
         let range = (strNumber).range(of: changeText)
         let attribute = NSMutableAttributedString.init(string: fullText)
         attribute.addAttribute(.foregroundColor, value: color , range: range)
         attribute.addAttribute(.font, value: font , range: range)
         self.attributedText = attribute
     }
  
}
extension UITextView {
  
  func changeDefaultWordColor (fullText : String , changeText : String ,color:UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),font:UIFont) {
          let strNumber: NSString = fullText as NSString
          let range = (strNumber).range(of: changeText)
          let attribute = NSMutableAttributedString.init(string: fullText)
          attribute.addAttribute(.foregroundColor, value: color , range: range)
          attribute.addAttribute(.font, value: font , range: range)
          self.attributedText = attribute
      }
}
//TO REMOVE CHARACTERS FROM DEVICE TOKEN STRING
extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}

extension UIColor {
  
  
  convenience init?(darkThemedColor:DARK_THEME_COLORS){
    
    self.init(named: darkThemedColor.rawValue)
    
  }
  
  
}
extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}

