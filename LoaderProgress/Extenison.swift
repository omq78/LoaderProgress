//
//  Extenison.swift
//  LoaderProgress
//
//  Created by Omar Alqabbani on 7/4/19.
//  Copyright © 2019 OmarALqabbani. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor{
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static let backgroundColor = rgb(r: 21, g: 22, b: 23)
    static let outlineStrokeColor = rgb(r: 234, g: 46, b: 111)
    static let trackStrokeColor = rgb(r: 56, g: 25, b: 49)
    static let pulsatingFillColor = rgb(r: 86, g: 30, b: 63)
}
