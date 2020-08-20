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
    
    var equalHit = false
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
            
            if let fir: NSDecimalNumber = NSDecimalNumber(string: first), let sec: NSDecimalNumber = NSDecimalNumber(string: second) {
                
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
            
            if !equalHit { first.append(String(num)) } else {
                first = String(num)
                equalHit = false
            }
            
            if let number: NSDecimalNumber = NSDecimalNumber(string: first) {
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
            
            let e = String(expression.string.filter { !" ".contains($0) })
            if String(e.last ?? " ").rangeOfCharacter(from: CharacterSet(charactersIn: "-*/+")) != nil {
                
                self.operation = op
                if let fir: NSDecimalNumber = NSDecimalNumber(string: first){
                    expression = NSMutableAttributedString(string: "\(fir)", attributes: [
                        NSAttributedString.Key.foregroundColor : Color().miscText!
                    ])
                    expression.append(NSMutableAttributedString(string: " \(op.rawValue) ", attributes: [
                        NSAttributedString.Key.foregroundColor : Color().operate!
                    ]))
                }
                
            } else {
            
                equals()
                self.operation = op
                if let fir: NSDecimalNumber = NSDecimalNumber(string: first) {
                    expression = NSMutableAttributedString(string: "\(fir)", attributes: [
                        NSAttributedString.Key.foregroundColor : Color().miscText!
                    ])
                    expression.append(NSMutableAttributedString(string: " \(op.rawValue) ", attributes: [
                        NSAttributedString.Key.foregroundColor : Color().operate!
                    ]))
                }
                
            }
            
            
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
            clear()
        case .decimal:
            decimal()
        case .percent:
            percent()
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
            
            if let fir: NSDecimalNumber = NSDecimalNumber(string: first), let sec: NSDecimalNumber = NSDecimalNumber(string: second) {
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
            
            if let number: NSDecimalNumber = NSDecimalNumber(string: first) {
                expression = NSMutableAttributedString(string: "\(number)", attributes: [
                    NSAttributedString.Key.foregroundColor : Color().miscText!
                ])
            }
            
        }
    }
    
    private func decimal() {
        if let op = operation {
            
            if second.rangeOfCharacter(from: CharacterSet(charactersIn: ".")) != nil { return }
            
            second.append(".")
            
            if let fir: NSDecimalNumber = NSDecimalNumber(string: first), let sec: NSDecimalNumber = NSDecimalNumber(string: second) {
                
                expression = NSMutableAttributedString(string: "\(fir)", attributes: [
                    NSAttributedString.Key.foregroundColor : Color().miscText!
                ])
                expression.append(NSMutableAttributedString(string: " \(op.rawValue) ", attributes: [
                    NSAttributedString.Key.foregroundColor : Color().operate!
                ]))
                expression.append(NSMutableAttributedString(string: "\(sec).", attributes: [
                    NSAttributedString.Key.foregroundColor : Color().miscText!
                ]))
            }
            
        } else {
            
            if first.rangeOfCharacter(from: CharacterSet(charactersIn: ".")) != nil { return }
            
            first.append(".")
            
            if let number: NSDecimalNumber = NSDecimalNumber(string: first) {
                expression = NSMutableAttributedString(string: "\(number).", attributes: [
                    NSAttributedString.Key.foregroundColor : Color().miscText!
                ])
                
            }
            
        }
        
    }
    
    func percent() {
        
        do {
            
            let exp = Expression(self.expression.string)
            let solution = try Float(exp.evaluate()) / 100
            self.result = "\(solution)"
            self.expression = NSMutableAttributedString(string: "\(self.result)", attributes: [
                NSAttributedString.Key.foregroundColor : Color().miscText!
            ])
            
        } catch {
            
            let exp = String(expression.string.filter { !" ".contains($0) })
            if String(exp.last ?? " ").rangeOfCharacter(from: CharacterSet(charactersIn: "-*/+")) != nil {
                
                expression.append(NSMutableAttributedString(string: "\(first)", attributes: [
                    NSAttributedString.Key.foregroundColor : Color().miscText!
                ]))
                percent()
                
            } else {
            
                self.result = "Error"
                expression = NSMutableAttributedString(string: "Error", attributes: [
                    NSAttributedString.Key.foregroundColor : Color().miscText!
                ])
                
            }
        }
        
        presenter.response(equation: self.expression, result: self.result)
        
        self.second = "0"
        self.equalHit = true
        self.operation = nil
        self.first = self.result
        
    }
    
    func clear() {
        
        if let op = operation {
            
            if let fir: NSDecimalNumber = NSDecimalNumber(string: first) {
                
                second = "0"
                expression = NSMutableAttributedString(string: "\(fir)", attributes: [
                    NSAttributedString.Key.foregroundColor : Color().miscText!
                ])
                expression.append(NSMutableAttributedString(string: " \(op.rawValue) ", attributes: [
                    NSAttributedString.Key.foregroundColor : Color().operate!
                ]))
                
            }
            
        } else {
            
            first = "0"
            expression = NSMutableAttributedString(string: "0", attributes: [
                NSAttributedString.Key.foregroundColor : Color().miscText!
            ])
            
        }
        
        presenter.response(equation: self.expression, result: self.result)
        
    }
    
}


// MARK: - Equals


extension Interactor: InteractorEquals {
    
    func equals() {
        
        do {
            
            let exp = Expression(self.expression.string)
            let solution = try Float(exp.evaluate()).clean
            self.result = "\(solution)"
            self.expression = NSMutableAttributedString(string: "\(self.result)", attributes: [
                NSAttributedString.Key.foregroundColor : Color().miscText!
            ])
            
        } catch {
            
            let exp = String(expression.string.filter { !" ".contains($0) })
            if String(exp.last ?? " ").rangeOfCharacter(from: CharacterSet(charactersIn: "-*/+")) != nil {
                
                expression.append(NSMutableAttributedString(string: "\(first)", attributes: [
                    NSAttributedString.Key.foregroundColor : Color().miscText!
                ]))
                equals()
                
            } else {
            
                self.result = "Error"
                expression = NSMutableAttributedString(string: "Error", attributes: [
                    NSAttributedString.Key.foregroundColor : Color().miscText!
                ])
                
            }
        }
        
        presenter.response(equation: self.expression, result: self.result)
        
        self.second = "0"
        self.equalHit = true
        self.operation = nil
        self.first = self.result
        
    }
    
}
