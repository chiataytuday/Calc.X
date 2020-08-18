//
//  HomeInteractor.swift
//  CalcX
//
//  Created by Kristopher Jackson on 8/16/20.
//

import Foundation
import Expression

// MARK: - Protocols


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
    
    var shouldResetResult = true
    var shouldResetEquation = true
    
    var presenter: Presenter!
    var result: String = "0"
    var equation: NSMutableAttributedString = NSMutableAttributedString(string: "0", attributes: [
        NSAttributedString.Key.foregroundColor : Color().miscText!,
    ])
    
    init(delegate: Any) {
        if let presenter = delegate as? Presenter {
            self.presenter = presenter
        }
    }
    
    private func hasOperator(_ expression: String) -> (Bool, Operation?) {
        for (_, char) in expression.enumerated() {
            switch String(char) {
            case Operation.add.rawValue:
                return (true, .add)
            case Operation.divide.rawValue:
                return (true, .divide)
            case Operation.multiply.rawValue:
                return (true, .multiply)
            case Operation.subtract.rawValue:
                return (true, .subtract)
            default:
                continue
            }
        }
        return (false, nil)
    }
    
    private func lastIsOperator(_ expression: String) -> Bool {
        guard let last = expression.last else {
            return false
        }
        
        switch String(last) {
        case Operation.add.rawValue:
            return true
        case Operation.divide.rawValue:
            return true
        case Operation.multiply.rawValue:
            return true
        case Operation.subtract.rawValue:
            return true
        default:
            return false
        }
    }
    
}


// MARK: - Number


extension Interactor: InteractorNumber {
    
    func number(_ num: Int) {
        
        let numberString = NSMutableAttributedString(string: String(num), attributes: [
            NSAttributedString.Key.foregroundColor : Color().miscText!
        ])
        
        if (shouldResetResult) || (result == "0") {
            self.result = String(num)
        } else {
            self.result.append(String(num))
        }
        
        if (shouldResetEquation) || (equation.string == "0")  {
            self.equation = numberString
        } else {
            self.equation.append(numberString)
        }
        
        self.shouldResetResult = false
        self.shouldResetEquation = false
        
        self.presenter.response(equation: equation, result: result)
    }
    
}


// MARK: - Operations


extension Interactor: InteractorOperation {
    
    func operation(_ op: Operation) {
        
        let opString = NSMutableAttributedString(string: String(op.rawValue), attributes: [
            NSAttributedString.Key.foregroundColor : Color().operate!,
        ])
        
        let (bool, _) = hasOperator(equation.string)
        
        if !bool {
            
            self.shouldResetResult = true
            self.shouldResetEquation = false
            self.equation.append(opString)
            
        } else {
            
            if lastIsOperator(equation.string) {
                
                self.equation.deleteCharacters(in: NSRange(location: self.equation.length - 1, length: 1))
                self.equation.append(opString)
                
            } else {
                
                self.shouldResetResult = true
                let expression = Expression(self.equation.string)
                let solution = try! expression.evaluate() as NSNumber
                self.result = solution.stringValue
                self.equation = NSMutableAttributedString(string: solution.stringValue, attributes: [
                    NSAttributedString.Key.foregroundColor : Color().miscText!,
                ])
                self.equation.append(opString)
                
            }
            
        }
        
        
        self.presenter.response(equation: equation, result: String(result))
    }
    
}


// MARK: - Miscellaneous


extension Interactor: InteractorMiscellaneous {
    
    func miscellaneous(_ misc: Miscellaneous) {
        switch misc {
        case .clear:
            return
        case .decimal:
            self.equation.append(opString)
        case .percent:
            return
        case .sign:
            return
        default:
            
            shouldResetResult = true
            shouldResetEquation = true
            
            self.result = "0"
            self.equation = NSMutableAttributedString(string: "0", attributes: [
                NSAttributedString.Key.foregroundColor : Color().miscText!,
            ])
            self.presenter.response(equation: equation, result: result)
        }
    }
    
}
