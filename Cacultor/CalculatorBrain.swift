//
//  CalculatorBrain.swift
//  Cacultor
//
//  Created by Vamsi on 13/06/17.
//  Copyright © 2017 Vamsi. All rights reserved.
//

import Foundation
//func changeSign(operand:Double) -> Double {
//    return -operand
//}
//func multiply(op1:Double,op2:Double) ->Double{
//
//    return op1*op2
//}
struct CalculatorBrain {
    
   
   private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double,Double) -> Double)
        case equals
    }
    
    private var operations:Dictionary<String,Operation> = ["π" : Operation.constant(Double.pi),
                                                        "e" : Operation.constant(M_E),
                                                        "√" : Operation.unaryOperation(sqrt),
                                                        "cos" : Operation.unaryOperation(cos),
                                                        "±" : Operation.unaryOperation({-$0 }),
                                                        "×" : Operation.binaryOperation({ $0*$1 }),
                                                        "+" : Operation.binaryOperation({ $0+$1 }),
                                                        "-" : Operation.binaryOperation({ $0-$1 }),
                                                        "÷" : Operation.binaryOperation({ $0/$1 }),
                                                        "=" : Operation.equals]
   
    private var accumulator: Double?
    
    mutating func performOperation(_ symbol: String) {
       
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                
                if accumulator != nil {
                
                accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOpration = PendingBinaryOperation( function:function ,firstOperand:accumulator!)
                    accumulator = nil
                }
                
            case .equals:
                performPendingBinaryOperation()
            }
        }
    
    }
    mutating private func performPendingBinaryOperation(){
        
        if pendingBinaryOpration != nil && accumulator != nil {
            accumulator = pendingBinaryOpration?.perform(with: accumulator!)
            pendingBinaryOpration = nil
        }
    
    }
    private var pendingBinaryOpration :PendingBinaryOperation?
    
    
    private struct PendingBinaryOperation{
       
        let function :(Double , Double) -> Double
        
        let firstOperand : Double
        func  perform(with secondOperand : Double) -> Double {
            return function(firstOperand,secondOperand)
        }
    }
    mutating func setOperand(_ operand: Double){
    
    accumulator = operand
    }
    
    var result: Double?{
        get {
        
        return accumulator
        }
    }
}
