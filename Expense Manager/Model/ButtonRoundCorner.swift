//
//  ButtonRoundCorner.swift
//  Expense Manager
//
//  Created by Rukhsar on 18/09/2020.
//  Copyright © 2020 Rukhsar. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    func roundCorners(corners: UIRectCorner, cornerRadius: Double) {
        
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let bezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = bezierPath.cgPath
        self.layer.mask = shapeLayer
    }
}
