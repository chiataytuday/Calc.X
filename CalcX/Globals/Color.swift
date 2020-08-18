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
    
    init() {
        switch mode {
        case .dark:
            self.logo_primary = UIColor.white
            self.number = #colorLiteral(red: 0.9881597161, green: 0.9882778525, blue: 0.9881196618, alpha: 1)
            self.main = UIColor(red: 0.1028274223, green: 0.09780896455, blue: 0.1022514775, alpha: 1)
            self.operate = UIColor(red: 0.9928788543, green: 0.2422792315, blue: 0.2295525968, alpha: 1)
            self.background = UIColor(red: 0.0813773945, green: 0.08657380193, blue: 0.07768137008, alpha: 1)
            self.miscText = UIColor(red: 0.3489903212, green: 0.3490361571, blue: 0.348974824, alpha: 1)
            self.number_background = UIColor(red: 0.1833866239, green: 0.1884745657, blue: 0.1839692891, alpha: 1)
            self.number_border = UIColor(red: 0.1833866239, green: 0.1884745657, blue: 0.1839692891, alpha: 0.5)
            self.operate_border = UIColor(red: 0.3002343476, green: 0.1191364452, blue: 0.1200929061, alpha: 1)
            self.logo_secondary = UIColor(red: 0.9926634431, green: 0.2478593588, blue: 0.223863095, alpha: 1)
        
        default:
            self.number = #colorLiteral(red: 0.101949431, green: 0.1019672081, blue: 0.1019433513, alpha: 1)
            self.main = UIColor(red: 0.9999071956, green: 1, blue: 0.999881804, alpha: 1)
            self.operate = UIColor(red: 0.9928788543, green: 0.2422792315, blue: 0.2295525968, alpha: 1)
            self.background = UIColor(red: 0.9754959941, green: 0.9806658626, blue: 0.9760413766, alpha: 1)
            self.miscText = UIColor(red: 0.7332299352, green: 0.7334356904, blue: 0.7289325595, alpha: 1)
            self.number_background = UIColor(red: 0.9176233411, green: 0.9176161885, blue: 0.9218498468, alpha: 1)
            self.number_border = UIColor(red: 0.9176233411, green: 0.9176161885, blue: 0.9218498468, alpha: 0.5)
            self.operate_border = UIColor(red: 0.9922958016, green: 0.8417218328, blue: 0.8356825709, alpha: 1)
            self.logo_primary = UIColor(red: 0.09886016697, green: 0.09395896643, blue: 0.09402290732, alpha: 1)
            self.logo_secondary = UIColor(red: 0.9926634431, green: 0.2478593588, blue: 0.223863095, alpha: 1)
            
        }
    }
    
    var main: UIColor!
    var background: UIColor!
    var number: UIColor!
    var operate: UIColor!
    var miscText: UIColor!
    var number_background: UIColor!
    var number_border: UIColor!
    var operate_border: UIColor!
    let logo_primary: UIColor!
    let logo_secondary: UIColor!
    
}
