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
    @IBOutlet weak var amountPerPersonTextField: UILabel!
    @IBOutlet weak var tipPercentageTextField: UITextField!
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var billAmountStackView: UIStackView!
    @IBOutlet weak var tipPercentageStackView: UIStackView!
    @IBOutlet weak var splitLabel: UILabel!
    
    var billAmount = 0.00;
    var prevTipAmount = 0.0;
    var tipPercentage = 0;
    var totalAmount = 0.00;
    
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
        
        billAmountTextField.addTarget(self, action: #selector(billAmountChanged(_:)), for: UIControl.Event.editingChanged)
        tipPercentageTextField.addTarget(self, action: #selector(tipAmountChanged(_ :)), for: UIControl.Event.editingChanged)
    }
    
    @objc func billAmountChanged(_ textField: UITextField) {
        print(billAmountTextField.text!)
    
        // unwrap the values to use them using if let
        if let billAmount = Double(billAmountTextField.text!) {
            totalAmount = billAmount
            amountPerPersonTextField.text = String(format: "%.3f", totalAmount)
        }
    }
    
    @objc func tipAmountChanged(_ textField: UITextField) {
        print("prevTipAmount=", Double(prevTipAmount))
        print("currentTip=", tipPercentageTextField.text!)
        totalAmount -= Double(prevTipAmount)
        
        if let tipAmount = Int(tipPercentageTextField.text!) {
            totalAmount += (totalAmount * (Double(tipAmount)/100))
            prevTipAmount = totalAmount * (Double(tipAmount)/100)
            print("totalAmount=", totalAmount)
            amountPerPersonTextField.text = String(totalAmount)
        }
        else {
            prevTipAmount = 0.00
            print("totalAmount=", totalAmount)
            amountPerPersonTextField.text = String(totalAmount)
        }
    }
    
    // dismiss keyboard when tapping anywhere outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

