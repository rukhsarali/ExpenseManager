//
//  UIButton.swift
//  Expense Manager
//
//  Created by Rukhsar on 14/09/2020.
//  Copyright © 2020 Rukhsar. All rights reserved.
//

import Foundation
import UIKit
struct UIButtonUpdate {
    //MARK: - update ui button in viewcontroller
    func buttonUI (color : UIColor , BtnImage : UIImageView , BtnView : UIView) {
        let incomeImage =   BtnImage.image?.withRenderingMode(.alwaysTemplate)
        BtnImage.image = incomeImage
        BtnImage.tintColor = UIColor.white
        BtnImage.backgroundColor = color
        BtnImage.layer.cornerRadius = 12
        BtnView.layer.cornerRadius = 12
    }
}



