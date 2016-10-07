//
//  calculator.swift
//  calculator.app
//
//  Created by 余晖 on 16/9/21.
//  Copyright © 2016年 余晖. All rights reserved.
//

import Foundation

struct compute {
    
    enum solution {
        case add
        case mul
        case div
        case index
        case none
    }
    
    private var currentSolution: solution = .none
    
    mutating func setCurrentSolution(temporarySolution: solution)
    {
        currentSolution = temporarySolution
    }
    
    func getResult(operatorNum: Double,operatoredNum: Double) -> String {
        var returnThing = ""
        switch currentSolution {
        case .add:
            returnThing = "\(operatorNum + operatoredNum)"
        case .mul:
            returnThing = "\(operatorNum * operatoredNum)"
        case .div where operatoredNum != 0 :
            returnThing = "\(operatorNum / operatoredNum)"
        case .index:
            var current = operatorNum
            current = pow(operatorNum, operatoredNum)
            returnThing = "\(current)"
        case .none:
            returnThing = "Error: you didn't chose"
        default :
            returnThing = "0 unable to be divided"
        }
        return returnThing
        
    }
    
}
