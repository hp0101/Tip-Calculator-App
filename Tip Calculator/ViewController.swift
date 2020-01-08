//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Hung Phan on 12/18/19.
//  Copyright © 2019 Hung Phan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var amountPerPersonTextField: UILabel!
    @IBOutlet weak var amountPerPersonStackView: UIStackView!
    
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var billAmountStackView: UIStackView!

    @IBOutlet weak var tipPercentageTextField: UITextField!
    @IBOutlet weak var tipPercentageStackView: UIStackView!
    @IBOutlet weak var splitLabel: UILabel!
    
    var billAmount : Double = 0.0;
    
    var tipPercentage : Double = 0.0;
    
    var amountPerPerson : Double = 0.0;
    
    var splitAmount : Double = 1.0;
    
    @IBAction func sliderAction(_ sender: UISlider) {
        
        let step : Float = 1
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        
        splitAmount = Double(sender.value)
        let charArr = splitLabel.text?.split(separator: " ")
        if Int(sender.value) == 1 {
            self.splitLabel.text = "Split For 1 Person"
        }
        else {
            self.splitLabel.text = "\(charArr![0]) \(charArr![1]) \(Int(sender.value)) People"
        }
        
        updateAmountPerPerson()
        
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
        
        billAmountTextField.addTarget(self, action: #selector(billAmountChanged(_:)), for: UIControl.Event.editingChanged)
        tipPercentageTextField.addTarget(self, action: #selector(tipAmountChanged(_ :)), for: UIControl.Event.editingChanged)
        
    }
    
    @objc func billAmountChanged(_ textField: UITextField) {
        
        if let newBillAmount = Double(textField.text!) {
            billAmount = newBillAmount
        }
        else {
            billAmount = 0.0
        }
        
        updateAmountPerPerson()
    }
    
    @objc func tipAmountChanged(_ textField: UITextField) {
        
        if let newTipPercentage = Double(textField.text!) {
            tipPercentage = newTipPercentage
        }
        else {
            tipPercentage = 0.0
        }
        
        updateAmountPerPerson()
    }
    
    func updateAmountPerPerson() {
        amountPerPerson = (billAmount + (billAmount * (tipPercentage / 100))) / splitAmount
        amountPerPersonTextField.text = String(format: "%.2f", amountPerPerson)
    }
    
    // dismiss keyboard when tapping anywhere outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

