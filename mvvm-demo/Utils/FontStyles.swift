//
//  CustomLabel.swift
//  TodoNote
//
//  Created by Adeel Kiani on 07/03/2019.
//  Copyright © 2019 Adeel Kiani. All rights reserved.
//

import UIKit


fileprivate let SIZE_HUGE : String = "huge"
fileprivate let SIZE_XLARGE : String = "xlarge"
fileprivate let SIZE_LARGE : String = "large"
fileprivate let SIZE_MEDIUM: String = "medium"
fileprivate let SIZE_MEDIUM_SMALL: String = "mediumSmall"
fileprivate let SIZE_SMALL : String = "small"
fileprivate let SIZE_XSMALL : String = "xsmall"

fileprivate let FONT_AVENIR_LIGHT : String = "light"
fileprivate let FONT_AVENIR_BOOK : String = "book"
fileprivate let FONT_AVENIR_HEAVY : String = "heavy"

//@IBDesignable
extension UILabel {

    @IBInspectable
    var fontSize :String{
        
      get {
      return SIZE_MEDIUM
      }
        set {
            if newValue == SIZE_HUGE {
                self.font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_HUGE))
            }
            else if newValue == SIZE_XLARGE {
                self.font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_XLARGE))
            }
            else if newValue == SIZE_LARGE {
                self.font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_LARGE))
            }
            else if newValue == SIZE_MEDIUM {
                self.font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_MEDIUM))
            }
            else if newValue == SIZE_MEDIUM_SMALL {
                self.font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_MEDIUM_SMALL))
            }
           else  if newValue == SIZE_SMALL {
                self.font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_SMALL))
            }
            else  if newValue == SIZE_XSMALL {
              self.font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_XSMALL))
            }
              
            else  {
                self.font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_MEDIUM))
            }
        }
    }
    
    @IBInspectable
    var isBold :Bool {
      get {
        return false
      }
        set {
            if newValue {
              self.font = UIFont.boldSystemFont(ofSize: font.pointSize)
            }
            else {
                self.font = UIFont.systemFont(ofSize: font.pointSize)
            }
        }
    }
    
    @IBInspectable
    var fontFamily :String {
        
      get {
        return FONT_FAMILY_AVENIR_BOOK
      }
      
        set {
            
            if newValue == FONT_AVENIR_LIGHT {
              
                self.font = UIFont.init(name: FONT_FAMILY_AVENIR_LIGHT, size: font.pointSize)
            }
            else if newValue == FONT_AVENIR_BOOK  {
                self.font = UIFont.init(name: FONT_FAMILY_AVENIR_BOOK, size: font.pointSize)

            }
            else if newValue == FONT_AVENIR_HEAVY  {
                self.font = UIFont.init(name: FONT_FAMILY_AVENIR_HEAVY, size: font.pointSize)
            }
            else {
        self.font = UIFont.init(name: FONT_FAMILY_AVENIR_LIGHT, size: font.pointSize)
      }
    }
  }
}
extension UIButton {

    @IBInspectable
    var fontSize :String{
        
      get {
      return SIZE_MEDIUM
      }
        set {
            if newValue == SIZE_HUGE {
              self.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_HUGE))
            }
            else if newValue == SIZE_XLARGE {
              self.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_XLARGE))
            }
            else if newValue == SIZE_LARGE {
                titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_LARGE))
            }
            else if newValue == SIZE_MEDIUM {
                titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_MEDIUM))
            }
           else  if newValue == SIZE_SMALL {
                titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_SMALL))
            }
            else  if newValue == SIZE_MEDIUM_SMALL {
                titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_MEDIUM_SMALL))
            }
            else  if newValue == SIZE_XSMALL {
                titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_XSMALL))
            }
            else  {
                titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_MEDIUM))
            }
        }
    }
    
    @IBInspectable
    var isBold :Bool {
      get {
        return false
      }
        set {
            if newValue {
              titleLabel?.font = UIFont.boldSystemFont(ofSize: titleLabel?.font.pointSize ?? CGFloat(TEXT_SIZE_MEDIUM))
            }
            else {
              titleLabel?.font = UIFont.systemFont(ofSize: titleLabel?.font.pointSize ?? CGFloat(TEXT_SIZE_MEDIUM))
            }
        }
    }
    
    @IBInspectable
    var fontFamily :String {
        
      get {
        return FONT_FAMILY_AVENIR_BOOK
      }
      
        set {
            
            if newValue == FONT_AVENIR_LIGHT {
              
              titleLabel?.font = UIFont.init(name: FONT_FAMILY_AVENIR_LIGHT, size: titleLabel?.font.pointSize ?? CGFloat(TEXT_SIZE_MEDIUM))!
            }
            else if newValue == FONT_AVENIR_BOOK  {
              titleLabel?.font = UIFont.init(name: FONT_FAMILY_AVENIR_BOOK, size: titleLabel?.font.pointSize ?? CGFloat(TEXT_SIZE_MEDIUM))

            }
            else if newValue == FONT_AVENIR_HEAVY  {
              titleLabel?.font = UIFont.init(name: FONT_FAMILY_AVENIR_HEAVY, size: titleLabel?.font.pointSize ?? CGFloat(TEXT_SIZE_MEDIUM))
            }
            else {
              titleLabel?.font = UIFont.init(name: FONT_FAMILY_AVENIR_LIGHT, size: titleLabel?.font.pointSize ?? CGFloat(TEXT_SIZE_MEDIUM))
      }
    }
  }
}

extension UITextField {

    @IBInspectable
    var fontSize :String{
        
      get {
      return SIZE_MEDIUM
      }
        set {
            if newValue == SIZE_HUGE {
                self.font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_HUGE))
            }
            else if newValue == SIZE_XLARGE {
                self.font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_XLARGE))
            }
            else if newValue == SIZE_LARGE {
                font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_LARGE))
            }
            else if newValue == SIZE_MEDIUM {
                font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_MEDIUM))
            }
           else  if newValue == SIZE_SMALL {
               font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_SMALL))
            }
            else  if newValue == SIZE_MEDIUM_SMALL {
                font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_MEDIUM_SMALL))
               }
            else  if newValue == SIZE_XSMALL {
                font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_XSMALL))
            }
            else  {
               font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_MEDIUM))
            }
        }
    }
    
    @IBInspectable
    var isBold :Bool {
      get {
        return false
      }
        set {
            if newValue {
              font = UIFont.boldSystemFont(ofSize: font?.pointSize ?? CGFloat(TEXT_SIZE_MEDIUM))
            }
            else {
              font = UIFont.systemFont(ofSize: font?.pointSize ?? CGFloat(TEXT_SIZE_MEDIUM))
            }
        }
    }
    
    @IBInspectable
    var fontFamily :String {
        
      get {
        return FONT_FAMILY_AVENIR_BOOK
      }
      
        set {
            
            if newValue == FONT_AVENIR_LIGHT {
              
            font = UIFont.init(name: FONT_FAMILY_AVENIR_LIGHT, size: font?.pointSize ?? CGFloat(TEXT_SIZE_MEDIUM))!
            }
            else if newValue == FONT_AVENIR_BOOK  {
              font = UIFont.init(name: FONT_FAMILY_AVENIR_BOOK, size: font?.pointSize ?? CGFloat(TEXT_SIZE_MEDIUM))

            }
            else if newValue == FONT_AVENIR_HEAVY  {
             font = UIFont.init(name: FONT_FAMILY_AVENIR_HEAVY, size: font?.pointSize ?? CGFloat(TEXT_SIZE_MEDIUM))
            }
            else {
            font = UIFont.init(name: FONT_FAMILY_AVENIR_LIGHT, size: font?.pointSize ?? CGFloat(TEXT_SIZE_MEDIUM))
      }
    }
  }
}

extension UITextView {

    @IBInspectable
    var fontSize :String{
        
      get {
      return SIZE_MEDIUM
      }
        set {
            if newValue == SIZE_HUGE {
                self.font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_HUGE))
            }
            else if newValue == SIZE_XLARGE {
                self.font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_XLARGE))
            }
            else if newValue == SIZE_LARGE {
                font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_LARGE))
            }
            else if newValue == SIZE_MEDIUM {
                font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_MEDIUM))
            }
            else  if newValue == SIZE_MEDIUM_SMALL {
                  font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_MEDIUM_SMALL))
                  }
           else  if newValue == SIZE_SMALL {
               font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_SMALL))
            }
            else  if newValue == SIZE_XSMALL {
                font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_XSMALL))
            }
            else  {
               font = UIFont.systemFont(ofSize: CGFloat(TEXT_SIZE_MEDIUM))
            }
        }
    }
    
    @IBInspectable
    var isBold :Bool {
      get {
        return false
      }
        set {
            if newValue {
              font = UIFont.boldSystemFont(ofSize: font?.pointSize ?? CGFloat(TEXT_SIZE_MEDIUM))
            }
            else {
              font = UIFont.systemFont(ofSize: font?.pointSize ?? CGFloat(TEXT_SIZE_MEDIUM))
            }
        }
    }
    
    @IBInspectable
    var fontFamily :String {
        
      get {
        return FONT_FAMILY_AVENIR_BOOK
      }
      
        set {
            
            if newValue == FONT_AVENIR_LIGHT {
              
            font = UIFont.init(name: FONT_FAMILY_AVENIR_LIGHT, size: font?.pointSize ?? CGFloat(TEXT_SIZE_MEDIUM))!
            }
            else if newValue == FONT_AVENIR_BOOK  {
              font = UIFont.init(name: FONT_FAMILY_AVENIR_BOOK, size: font?.pointSize ?? CGFloat(TEXT_SIZE_MEDIUM))

            }
            else if newValue == FONT_AVENIR_HEAVY  {
             font = UIFont.init(name: FONT_FAMILY_AVENIR_HEAVY, size: font?.pointSize ?? CGFloat(TEXT_SIZE_MEDIUM))
            }
            else {
            font = UIFont.init(name: FONT_FAMILY_AVENIR_LIGHT, size: font?.pointSize ?? CGFloat(TEXT_SIZE_MEDIUM))
              
      }
    }
  }
}
