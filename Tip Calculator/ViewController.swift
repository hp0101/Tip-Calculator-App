//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Hung Phan on 12/18/19.
//  Copyright © 2019 Hung Phan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var amountPerPersonStackView: UIStackView!
    @IBOutlet weak var tipPercentageTextField: UITextField!
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var billAmountStackView: UIStackView!
    @IBOutlet weak var tipPercentageStackView: UIStackView!
    @IBOutlet weak var splitLabel: UILabel!
    
    @IBAction func sliderAction(_ sender: UISlider) {
        
        let charArr = splitLabel.text?.split(separator: " ")
        if (Int(sender.value) == 1) {
            self.splitLabel.text = "Split For 1 Person"
        }
        else {
            let newText = "\(charArr![0]) \(charArr![1]) \(Int(sender.value)) People"
            
            self.splitLabel.text = newText
        }
    }
    
    // add underline for each stack view
    func addUnderline(inputView : UIStackView) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: inputView.frame.height - 1, width: inputView.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor(red: 138/255.0, green: 242/255.0, blue: 160/255.0, alpha: 1.0).cgColor
        inputView.layer.addSublayer(bottomLine)
    }
    
    func addUnderlineOrange(inputView: UIStackView) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: inputView.frame.height - 1, width: inputView.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor(red: 1.000, green: 0.584, blue: 0.000, alpha: 1.0).cgColor
        inputView.layer.addSublayer(bottomLine)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add underline for each stack view
        addUnderline(inputView: billAmountStackView)
        addUnderline(inputView: tipPercentageStackView)
        addUnderlineOrange(inputView: amountPerPersonStackView)
        
        
    }
    
    // dismiss keyboard when tapping anywhere outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

