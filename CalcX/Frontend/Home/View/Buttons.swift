//
//  Buttons.swift
//  CalcX
//
//  Created by Kristopher Jackson on 8/16/20.
//

import UIKit

class Button: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
        self.titleLabel?.font = .systemFont(ofSize: 26, weight: .bold)
        
    }
    
}

class Equal: Button {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addTarget(self, action: #selector(pressed), for: .touchUpInside)
    }
    
    @objc private func pressed() {
        if let view = window?.rootViewController as? HomeView {
//            view.presenter.forward(operator: .equals)
        }
    }
    
}

class Operator: Button {
    
    var operation: Operation!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let op = self.titleLabel?.text ?? "+" {
            switch op {
            case "–":
                self.operation = .subtract
            case "*":
                self.operation = .multiply
            case "/":
                self.operation = .divide
            default:
                self.operation = .add
            }
        }
        self.addTarget(self, action: #selector(pressed), for: .touchUpInside)
    }
    
    @objc private func pressed() {
        if let view = window?.rootViewController as? HomeView {
            view.presenter.forward(operator: operation)
        }
    }
    
}

class Number: Button {
    
    var number: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let number = Int(self.titleLabel?.text ?? "0") {
            self.number = number
        }
        self.addTarget(self, action: #selector(pressed), for: .touchUpInside)
    }
    
    @objc private func pressed() {
        if let view = window?.rootViewController as? HomeView {
            view.presenter.forward(number: number)
        }
    }
    
}

class Misc: Button {
    
    var misc: Miscellaneous!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let misc = self.titleLabel?.text ?? "%" {
            switch misc {
            case Miscellaneous.clear.rawValue:
                self.misc = .clear
            case Miscellaneous.decimal.rawValue:
                self.misc = .decimal
            case Miscellaneous.percent.rawValue:
                self.misc = .percent
            case Miscellaneous.sign.rawValue:
                self.misc = .sign
            default:
                self.misc = .allClear
            }
        }
        self.addTarget(self, action: #selector(pressed), for: .touchUpInside)
    }
    
    @objc private func pressed() {
        if let view = window?.rootViewController as? HomeView {
            view.presenter.forward(miscellaneous: misc)
        }
    }
    
}
