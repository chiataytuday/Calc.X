//
//  HomeInteractor.swift
//  CalcX
//
//  Created by Kristopher Jackson on 8/16/20.
//

import Foundation
import Expression

// MARK: - Protocols

protocol InteractorEquals {
    func equals()
}

protocol InteractorNumber {
    func number(_ num: Int)
}

protocol InteractorOperation {
    func operation(_ op: Operation)
}

protocol InteractorMiscellaneous {
    func miscellaneous(_ misc: Miscellaneous)
}


// MARK: - Base Class


class Interactor {
    
    var first: String = "0"
    var second: String = "0"
    var operation: Operation?
    
    var result = "0"
    var expression = NSMutableAttributedString(string: "0", attributes: [
        NSAttributedString.Key.foregroundColor : Color().miscText!
    ])
    
    var presenter: Presenter!
    
    init(delegate: Any) {
        if let presenter = delegate as? Presenter {
            self.presenter = presenter
        }
    }
    
}


// MARK: - Number


extension Interactor: InteractorNumber {
    
    func number(_ num: Int) {
        if let op = operation {
                    
            second.append(String(num))
            if let fir: NSNumber = Double(first) as NSNumber?, let sec: NSNumber = Double(second) as NSNumber? {
                
                expression = NSMutableAttributedString(string: "\(fir)", attributes: [
                    NSAttributedString.Key.foregroundColor : Color().miscText!
                ])
                expression.append(NSMutableAttributedString(string: " \(op.rawValue) ", attributes: [
                    NSAttributedString.Key.foregroundColor : Color().operate!
                ]))
                expression.append(NSMutableAttributedString(string: "\(sec)", attributes: [
                    NSAttributedString.Key.foregroundColor : Color().miscText!
                ]))
                
            }
            
        } else {
            
            first.append(String(num))
            if let number: NSNumber = Double(first) as NSNumber? {
                
                expression = NSMutableAttributedString(string: "\(number)", attributes: [
                    NSAttributedString.Key.foregroundColor : Color().miscText!
                ])
                
            }
            
        }
        
        presenter.response(equation: self.expression, result: self.result)
        
    }
    
}


// MARK: - Operations


extension Interactor: InteractorOperation {
    
    func operation(_ op: Operation) {
        
        var exp = expression.string
        if exp.first == "-" { exp = String(exp.dropFirst()) }
        
        if exp.rangeOfCharacter(from: CharacterSet(charactersIn: "-*/+")) != nil {
            
  
            
            
        } else {
            
            operation = op
            expression.append(NSMutableAttributedString(string: " \(op.rawValue) ", attributes: [
                NSAttributedString.Key.foregroundColor : Color().operate!
            ]))
            
        }
        
        presenter.response(equation: self.expression, result: self.result)
        
    }
    
}


// MARK: - Miscellaneous


extension Interactor: InteractorMiscellaneous {
    
    func miscellaneous(_ misc: Miscellaneous) {
        switch misc {
        case .clear:
            return
        case .decimal:
            return
        case .percent:
            return
        case .sign:
            sign()
        default:
            
            self.first = "0"
            self.second = "0"
            self.operation = nil
            self.result = "0"
            self.expression = NSMutableAttributedString(string: "0", attributes: [
                NSAttributedString.Key.foregroundColor : Color().miscText!
            ])
            
        }
        
        self.presenter.response(equation: self.expression, result: self.result)
    }
    
    
    private func sign() {
        if let op = operation {
            
            if second.contains("-") { second = String(second.dropFirst()) } else { second = "-\(second)" }
            
            if let fir: NSNumber = Double(first) as NSNumber?, let sec: NSNumber = Double(second) as NSNumber? {
                expression = NSMutableAttributedString(string: "\(fir)", attributes: [
                    NSAttributedString.Key.foregroundColor : Color().miscText!
                ])
                expression.append(NSMutableAttributedString(string: " \(op.rawValue) ", attributes: [
                    NSAttributedString.Key.foregroundColor : Color().operate!
                ]))
                expression.append(NSMutableAttributedString(string: "\(sec)", attributes: [
                    NSAttributedString.Key.foregroundColor : Color().miscText!
                ]))
            }
            
        } else {
            
            if first.contains("-") { first = String(first.dropFirst()) } else { first = "-\(first)" }
            
            if let number: NSNumber = Double(first) as NSNumber? {
                expression = NSMutableAttributedString(string: "\(number)", attributes: [
                    NSAttributedString.Key.foregroundColor : Color().miscText!
                ])
            }
            
        }
    }
    
}


// MARK: - Equals


extension Interactor: InteractorEquals {
    
    func equals() {
        
        do {
            
            let exp = Expression(self.expression.string)
            let solution = try exp.evaluate() as NSNumber
            self.result = "\(solution)"
            expression = NSMutableAttributedString(string: self.result, attributes: [
                NSAttributedString.Key.foregroundColor : Color().miscText!
            ])
            
        } catch {
            
            self.result = "Error"
            expression = NSMutableAttributedString(string: "Error", attributes: [
                NSAttributedString.Key.foregroundColor : Color().miscText!
            ])
            
        }
        
        presenter.response(equation: self.expression, result: self.result)
        
        self.second = "0"
        self.first = self.result
        
    }
    
}
