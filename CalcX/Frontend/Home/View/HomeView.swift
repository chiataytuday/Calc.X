//
//  ViewController.swift
//  CalcX
//
//  Created by Kristopher Jackson on 8/16/20.
//

import UIKit

protocol ViewResponse {
    func response(equation: NSAttributedString, result: String)
}

class HomeView: UIViewController {

    @IBOutlet weak var logo: UILabel!
    @IBOutlet weak var toggle: UIButton!
    @IBOutlet weak var formula: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var resultBackground: UIView!
    
    lazy var presenter = Presenter(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modeManager()
    }
    
    private func modeManager() {
        view.backgroundColor = Color().main
        resultBackground.backgroundColor = Color().background
        formatLogo()
        formatToggle()
        formatFormula()
        formatNumber()
    }

    private func formatLogo() {
        let attrString = NSMutableAttributedString(string: "Calc ", attributes: [
            NSAttributedString.Key.foregroundColor: Color().logo_primary!,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold),
        ])
        attrString.append(NSAttributedString(string: "X", attributes: [
            NSAttributedString.Key.foregroundColor: Color().logo_secondary!,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold),
        ]))
        logo.attributedText = attrString
    }
    
    private func formatToggle() {
        toggle.isHidden = true
        toggle.tintColor = Color().logo_primary
        toggle.setImage(UIImage(systemName: mode.rawValue), for: .normal)
    }
    
    private func formatFormula() {
        
    }
    
    private func formatNumber() {
        
    }
}


// MARK: - Button Actions


extension HomeView {
    
    @IBAction func toggle(_ sender: Any) {
        switch mode {
        case .dark:
            mode = .light
            UserDefaults.standard.set(Color.Mode.light.rawValue, forKey: "mode")
        default:
            mode = .dark
            UserDefaults.standard.set(Color.Mode.dark.rawValue, forKey: "mode")
        }
        modeManager()
    }
    
}


extension HomeView: ViewResponse {
    
    func response(equation: NSAttributedString, result: String) {
        self.number.text = result
        self.formula.attributedText = equation
    }
    
}
