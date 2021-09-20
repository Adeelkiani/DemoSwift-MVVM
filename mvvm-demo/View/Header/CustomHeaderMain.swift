//
//  Header_view_main.swift
//  TodoNote
//
//  Created by Adeel Kiani on 05/03/2019.
//  Copyright © 2019 Adeel Kiani. All rights reserved.
//

import UIKit

//@IBDesignable
class CustomHeaderMain: UIView {

    @IBOutlet weak var backButton: UIButton!

    @IBOutlet weak var backButtonLeftNSConstraint: NSLayoutConstraint!
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var headerName: UILabel!
    
    
    //    override func prepareForInterfaceBuilder() {
//        loadViewFromNib()
//    }
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
        setPadding()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
        setPadding()
    }
    
    func setPadding() {
        backButton.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)

    }
    
    func loadViewFromNib() {
//        let bundle = Bundle(for: type(of: self))
//        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
//        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
//        view.frame = bounds
//        view.autoresizingMask = [
//            UIView.AutoresizingMask.flexibleWidth,
//            UIView.AutoresizingMask.flexibleHeight
//        ]
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        addSubview(mainView);
        mainView.frame = self.bounds
        mainView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
  
  
    
}

