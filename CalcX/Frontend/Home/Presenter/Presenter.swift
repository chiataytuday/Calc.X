//
//  Presenter.swift
//  CalcX
//
//  Created by Kristopher Jackson on 8/16/20.
//

import UIKit

// MARK: - Protocols


protocol PresenterForward {
    func forward(number num: Int)
    func forward(operator op: Operation)
    func forward(miscellaneous misc: Miscellaneous)
}

protocol PresenterResponse {
    func response(equation: NSAttributedString, result: String)
}


// MARK: - Base Class


class Presenter {
    
    var view: HomeView!
    lazy var interactor = Interactor(delegate: self)
    
    init(delegate: Any) {
        if let view = delegate as? HomeView {
            self.view = view
        }
    }
    
}


// MARK: - Forwarding
// Forwards all actions from the UI to the interactor

extension Presenter: PresenterForward {
    
    func forward(number num: Int) {
        self.interactor.number(num)
    }
    
    func forward(operator op: Operation) {
        self.interactor.operation(op)
    }
    
    func forward(miscellaneous misc: Miscellaneous) {
        self.interactor.miscellaneous(misc)
    }
    
}


// MARK: - Response
// Sends all the responses from the interactor to UI

extension Presenter: PresenterResponse {
    
    func response(equation: NSAttributedString, result: String) {
        view.response(equation: equation, result: result)
    }
    
}
