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
    
    var billAmount : Double = 0.0;
    var tipAmount : Double = 0.0;
    var tipPercentage : Double = 0.0;
    var totalAmount : Double = 0.0;
    var splitAmount : Double = 1.0;
    var tipPercentageSet : Bool = false;
    var billAmountSet : Bool = false;
    
    @IBAction func sliderAction(_ sender: UISlider) {
        
        let step : Float = 1
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        
        splitAmount = Double(sender.value)
        
        let charArr = splitLabel.text?.split(separator: " ")
        if (Int(sender.value) == 1) {
            self.splitLabel.text = "Split For 1 Person"
            amountPerPersonTextField.text = String(format: "%.2f", totalAmount)
        }
        else {
            let newText = "\(charArr![0]) \(charArr![1]) \(Int(sender.value)) People"
            
            self.splitLabel.text = newText
            
            let newTotalAmount = totalAmount / Double(sender.value)
            amountPerPersonTextField.text = String(format: "%.2f", newTotalAmount)
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
//        prevTipAmount = 0.0
//        tipPercentage = 0
//        tipPercentageTextField.text = ""
//        tipPercentageTextField.attributedPlaceholder = NSAttributedString(string: "0")

        // unwrap the values to use them using if let
        if (tipPercentageSet) {
            billAmountSet = true
            if let newBillAmount = Double(billAmountTextField.text!) {
                billAmount = newBillAmount
                totalAmount = billAmount + (round(100*(billAmount * (tipPercentage/100)))/100)
//                print("tipPercentage==", tipPercentage)
                print("totalAmount===", totalAmount)
                totalAmount = totalAmount / splitAmount
                amountPerPersonTextField.text = String(totalAmount)
            }
            else {
//                print("totalAmount=", totalAmount)
                totalAmount = 0.0
                amountPerPersonTextField.text = ""
                amountPerPersonTextField.text = "0.0"
            }
        } else {
            if let billAmount = Double(billAmountTextField.text!) {
                totalAmount = billAmount
                amountPerPersonTextField.text = String(totalAmount)
            }
            else {
                amountPerPersonTextField.text = "0.0"
            }
        }
    }
    
    @objc func tipAmountChanged(_ textField: UITextField) {
        tipPercentageSet = true
//        print("currentTip=", tipPercentageTextField.text!)
        print("billAmountSet=", billAmountSet)
        if !billAmountSet {
            totalAmount -= round(100*tipAmount)/100
        }
        else {
            billAmountSet = false
            totalAmount = billAmount
        }
        
        if let newTipPercentage = Double(tipPercentageTextField.text!) {
            // update the prevTipAmount before adding it to the totalAmount
            print("tipAmountBEFORE=", tipAmount)
            print("totalAmountBEFORE=", totalAmount)
            tipPercentage = newTipPercentage
            tipAmount = round(100*(totalAmount * (tipPercentage / 100)))/100
            totalAmount += round(100*(totalAmount * (tipPercentage/100)))/100
            print("tipPercentage=", (tipPercentage / 100))
            print("tipAmountAFTER=", tipAmount)
            print("totalAmountAFTER=", totalAmount)
            totalAmount = totalAmount / splitAmount
            amountPerPersonTextField.text = String(format: "%.2f", totalAmount)
        }
        else {
            tipAmount = 0.0
            print("totalAmount=", totalAmount)
            amountPerPersonTextField.text = String(totalAmount)
        }
    }
    
    // dismiss keyboard when tapping anywhere outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

