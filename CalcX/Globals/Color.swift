//
//  Color.swift
//  CalcX
//
//  Created by Kristopher Jackson on 8/16/20.
//

import UIKit

var mode: Color.Mode = .light

class Color {
    
    enum Mode: String {
        case dark = "sun.max.fill"
        case light = "moon.stars.fill"
    }
    
    static let main: UIColor = #colorLiteral(red: 0.9960023761, green: 0.996121347, blue: 0.9959618449, alpha: 1)
    static let background: UIColor = #colorLiteral(red: 0.9754959941, green: 0.9806658626, blue: 0.9760413766, alpha: 1)
    static let number: UIColor = #colorLiteral(red: 0.1067036465, green: 0.101802595, blue: 0.101865299, alpha: 1)
    static let operate: UIColor = #colorLiteral(red: 0.9969629645, green: 0.2470276058, blue: 0.2234204113, alpha: 1)
    static let equal_background: UIColor = #colorLiteral(red: 0.9969629645, green: 0.2470276058, blue: 0.2234204113, alpha: 1)
    static let miscText: UIColor = #colorLiteral(red: 0.7755097747, green: 0.7806575894, blue: 0.7760632634, alpha: 1)
    static let miscText_dark: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8470588235)
    static let number_background: UIColor = #colorLiteral(red: 0.9175767303, green: 0.9176867604, blue: 0.9175391197, alpha: 1)
    static let number_border: UIColor = #colorLiteral(red: 0.9646322131, green: 0.9647476077, blue: 0.9645928741, alpha: 1)
    static let operate_border: UIColor = #colorLiteral(red: 0.9963396192, green: 0.8454332948, blue: 0.8525969982, alpha: 1)
    static let equal_border: UIColor = #colorLiteral(red: 0.9963396192, green: 0.8454332948, blue: 0.8525969982, alpha: 1)
    static let logo_primary: UIColor = #colorLiteral(red: 0.1067036465, green: 0.101802595, blue: 0.101865299, alpha: 1)
    static let logo_secondary: UIColor = #colorLiteral(red: 0.9969629645, green: 0.2470276058, blue: 0.2234204113, alpha: 1)
    
    init() {
        
    }
    
}
