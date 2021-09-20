//
//  BorderButton.swift
//  MvvmRxSwift
//
//  Created by Adeel Kiani on 13/10/2019.
//  Copyright © 2019 Adeel Kiani. All rights reserved.
//

import UIKit
import Material

@IBDesignable
class DesignableButton: UIButton {
  
}

//----------------UITextFiled----------------//

class DesignableTextField: UITextField {
  
  var padding =  UIEdgeInsets.zero {
    didSet { invalidateIntrinsicContentSize() }

  }

   @IBInspectable var bottomPadding: CGFloat {
     get { return padding.bottom }
     set { padding.bottom = newValue }
   }
   @IBInspectable var leftPadding: CGFloat {
     get { return padding.left }
     set { padding.left = newValue }
   }
   @IBInspectable var rightPadding: CGFloat {
     get { return padding.right }
     set { padding.right = newValue }
   }
   @IBInspectable var topPadding: CGFloat {
     get { return padding.top }
     set { padding.top = newValue }
   }

  override open func textRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: padding)
  }
  
  override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: padding)
  }
  
  override open func editingRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: padding)
  }
  
}

class ImageViewPadding: UIImageView {
  
  var padding =  UIEdgeInsets.zero {
    didSet { invalidateIntrinsicContentSize() }

  }
  
  //7162
  //testkey
   @IBInspectable var bottomPadding: CGFloat {
     get { return padding.bottom }
     set { padding.bottom = newValue }
   }
   @IBInspectable var leftPadding: CGFloat {
     get { return padding.left }
     set { padding.left = newValue }
   }
   @IBInspectable var rightPadding: CGFloat {
     get { return padding.right }
     set { padding.right = newValue }
   }
   @IBInspectable var topPadding: CGFloat {
     get { return padding.top }
     set { padding.top = newValue }
   }
  
  
  override var alignmentRectInsets: UIEdgeInsets {
    return UIEdgeInsets(top: padding.top, left: padding.left, bottom: padding.bottom, right: padding.right)
    }
}
