//
//  ViewController.swift
//  Calculator
//
//  Created by Евгений Сергеевич on 19.12.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    var stillTyping = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSign: String = ""
    var dotIsPlaced =  false
    var currentInput: Double {
        get {
            return Double(resultLabel.text!)!
        }
        set {
            let value = "\(newValue)"
            let valueArray =  value.components(separatedBy: ".")
            if valueArray[1] == "0" {
                resultLabel.text = "\(valueArray[0])"
            } else {
                resultLabel.text = "\(newValue)"
            }
            
            stillTyping = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        clearButton.isEnabled = false
        clearButton.isHighlighted = true
    }

    @IBAction func numberPressed(_ sender: UIButton) {
        let number = sender.currentTitle!
        clearButton.isEnabled =  true
        if stillTyping{
            if resultLabel.text!.count < 20 {
                resultLabel.text = resultLabel.text! + number
            }
        } else {
            resultLabel.text = number
            stillTyping = true
        }
        
       
        
    }
    @IBAction func twoOperandsSignPressed(_ sender: UIButton) {
        operationSign = sender.currentTitle!
        firstOperand = currentInput
        stillTyping =  false
        dotIsPlaced = false
    }
    
    func operateWithTwoOperands(operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        stillTyping = false
    }
    
    @IBAction func EquelOperandsPressed(_ sender: UIButton) {
        if stillTyping {
            secondOperand = currentInput
        }
        dotIsPlaced = false
        switch operationSign {
        case "+": operateWithTwoOperands {$0 + $1}
        case "-": operateWithTwoOperands {$0 - $1}
        case "✕": operateWithTwoOperands {$0 * $1}
        case "÷": operateWithTwoOperands {$0 / $1}
        default: break
        }
    }
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        resultLabel.text = "0"
        stillTyping = false
        operationSign = ""
        dotIsPlaced = false
        if resultLabel.text == "0" {
            clearButton.isEnabled = false
        } else {
            clearButton.isEnabled =  true
        }

    }
    
    @IBAction func plusMnusButtonPressed(_ sender: UIButton) {
        currentInput = -currentInput
    }
    
    @IBAction func procentButtonPressed(_ sender: UIButton) {
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput / 100
        }
    }
    
    @IBAction func sqrtButtonPressed(_ sender: UIButton) {
        currentInput = sqrt(currentInput)
    }
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        if stillTyping && !dotIsPlaced {
            resultLabel.text = resultLabel.text! + "."
            dotIsPlaced =  true
        } else if !stillTyping && !dotIsPlaced {
            resultLabel.text = "0."
        }
    }
}
