//
//  Gradient.swift
//  Hangman
//
//  Created by Vanessa Bergen on 2019-09-12.
//  Copyright © 2019 Vanessa Bergen. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addScreenGradient(color1: UIColor, color2: UIColor, color3: UIColor) {
        let layer = CAGradientLayer()
        layer.frame = UIScreen.main.bounds
        layer.colors = [color1.cgColor, color2.cgColor, color3.cgColor]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        self.layer.addSublayer(layer)
    }
    
    
}
