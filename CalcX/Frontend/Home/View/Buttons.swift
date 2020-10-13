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
        self.layer.borderWidth = 5
        self.backgroundColor = Color.equal_background
        self.setTitleColor(Color.main, for: .normal)
        self.layer.borderColor = Color.equal_border.cgColor
        self.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        self.addTarget(self, action: #selector(touchRelease), for: .touchDragExit)
        self.addTarget(self, action: #selector(touchRelease), for: .touchUpOutside)
        self.addTarget(self, action: #selector(touchRelease), for: .touchUpInside)
        self.addTarget(self, action: #selector(touchDown), for: .touchDown)
        self.addTarget(self, action: #selector(touchDown), for: .touchDragEnter)
    }
    
    @objc private func pressed() {
        if let view = window?.rootViewController as? HomeView {
            view.presenter.forwardEquals()
        }
    }
    
    @objc private func touchRelease() {
        self.setTitleColor(Color.main, for: .normal)
        UIView.animate(withDuration: 0.2) {
            self.layer.borderColor = Color.equal_border.cgColor
            self.backgroundColor = Color.equal_background
            self.layoutSubviews()
        }
    }
    
    @objc private func touchDown() {
        self.setTitleColor(Color.operate, for: .normal)
        UIView.animate(withDuration: 0.2) {
            self.backgroundColor = Color.equal_border
            self.layoutSubviews()
        }
    }
    
}

class Operator: Button {
    
    var operation: Operation!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let op = self.titleLabel?.text {
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
        self.setTitleColor(Color.operate, for: .normal)
        self.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        self.addTarget(self, action: #selector(touchRelease), for: .touchDragExit)
        self.addTarget(self, action: #selector(touchRelease), for: .touchUpOutside)
        self.addTarget(self, action: #selector(touchRelease), for: .touchUpInside)
        self.addTarget(self, action: #selector(touchDown), for: .touchDown)
        self.addTarget(self, action: #selector(touchDown), for: .touchDragEnter)
    }
    
    @objc private func pressed() {
        if let view = window?.rootViewController as? HomeView {
            view.presenter.forward(operator: operation)
        }
    }
    
    @objc private func touchRelease() {
        UIView.animate(withDuration: 0.2) {
            self.layer.borderWidth = 0
            self.backgroundColor = .clear
            self.layoutSubviews()
        }
    }
    
    @objc private func touchDown() {
        UIView.animate(withDuration: 0.2) {
            self.backgroundColor = Color.operate_border
            self.layoutSubviews()
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
        self.setTitleColor(Color.number, for: .normal)
        self.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        self.addTarget(self, action: #selector(touchRelease), for: .touchDragExit)
        self.addTarget(self, action: #selector(touchRelease), for: .touchUpOutside)
        self.addTarget(self, action: #selector(touchRelease), for: .touchUpInside)
        self.addTarget(self, action: #selector(touchDown), for: .touchDown)
        self.addTarget(self, action: #selector(touchDown), for: .touchDragEnter)
    }
    
    @objc private func pressed() {
        if let view = window?.rootViewController as? HomeView {
            view.presenter.forward(number: number)
        }
    }
    
    @objc private func touchRelease() {
        UIView.animate(withDuration: 0.2) {
            self.layer.borderWidth = 0
            self.backgroundColor = .clear
            self.layoutSubviews()
        }
    }
    
    @objc private func touchDown() {
        UIView.animate(withDuration: 0.2) {
            self.layer.borderWidth = 5
            self.layer.borderColor = Color.number_border.cgColor
            self.backgroundColor = Color.number_background
            self.layoutSubviews()
        }
    }
    
}

class Misc: Button {
    
    var misc: Miscellaneous!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let misc = self.titleLabel?.text {
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
        self.setTitleColor(Color.miscText, for: .normal)
        self.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        self.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        self.addTarget(self, action: #selector(touchRelease), for: .touchDragExit)
        self.addTarget(self, action: #selector(touchRelease), for: .touchUpOutside)
        self.addTarget(self, action: #selector(touchRelease), for: .touchUpInside)
        self.addTarget(self, action: #selector(touchDown), for: .touchDown)
        self.addTarget(self, action: #selector(touchDown), for: .touchDragEnter)
    }
    
    @objc private func pressed() {
        if let view = window?.rootViewController as? HomeView {
            view.presenter.forward(miscellaneous: misc)
        }
    }
    
    @objc private func touchRelease() {
        self.setTitleColor(Color.miscText, for: .normal)
        UIView.animate(withDuration: 0.2) {
            self.layer.borderWidth = 0
            self.backgroundColor = .clear
            self.layoutSubviews()
        }
    }
    
    @objc private func touchDown() {
        self.setTitleColor(Color.miscText_dark, for: .normal)
        UIView.animate(withDuration: 0.2) {
            self.layer.borderWidth = 5
            self.layer.borderColor = Color.number_border.cgColor
            self.backgroundColor = Color.number_background
            self.layoutSubviews()
        }
    }
    
}
