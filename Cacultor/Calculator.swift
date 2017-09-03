//
//  ViewController.swift
//  Cacultor
//
//  Created by Vamsi on 13/06/17.
//  Copyright © 2017 Vamsi. All rights reserved.
//

import UIKit

class Calculator: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTyping:Bool = false
    var displayValue : Double{
        get{
        return Double(display.text!)!
        }
        set{
        
        display.text = String(newValue)
        }
    
    }
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
       
        if userIsInTheMiddleOfTyping {
        
        brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        
        }
        if let mathematicalSymbol = sender.currentTitle{
           brain.performOperation(mathematicalSymbol)
            
        }
        if let result = brain.result {
            displayValue = result
        }
    }
   
    @IBAction func touchDigit(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit

            
        }else{
        
        display.text = digit
            userIsInTheMiddleOfTyping = true
        
        }
    }

}

