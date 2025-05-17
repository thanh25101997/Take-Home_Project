//
//  UIView_Ext.swift
//  Take-Home
//
//  Created by Van Thanh on 17/5/25.
//

import UIKit

extension UIView {
    
    func sketchShadow(x: CGFloat = 2,
                      y: CGFloat = 2,
                      opacity: Float = 0.4,
                      radius: CGFloat = 4,
                      color: UIColor = .black) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }
    
    func makeCircle() {
        clipsToBounds = true
        layer.cornerRadius = frame.width / 2
    }
    
    func drawBackGroundView(color: UIColor = #colorLiteral(red: 0.9211266637, green: 0.9012937546, blue: 0.9574692845, alpha: 1),
                            shadowRadius: CGFloat = 2,
                            cornerRadius: CGFloat = 6) {
        guard let superview = self.superview else { return }
        
         let shadowLayer = CALayer()
         shadowLayer.cornerRadius = cornerRadius
         shadowLayer.backgroundColor = color.cgColor
         shadowLayer.frame = self.frame.insetBy(dx: -2, dy: -2)
         superview.layer.insertSublayer(shadowLayer, below: self.layer)
    }
    
}
