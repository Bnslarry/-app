//
//  ViewController.swift
//  calculator.app
//
//  Created by 余晖 on 16/9/21.
//  Copyright © 2016年 余晖. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var calculator = compute()
    var numStr = ""
    var register = ""
    var temporary = ""
    var memory = 0.0
    var flag = 0
    var transform = 0
    var pattern = 0
    var num:[Double] = []
    var char:[String] = []
    var star = 0
    var length = 0
    var length2 = 0
    var ifParenthesis = ""
    var help = ""
    
    @IBOutlet weak var Screen: UILabel!
    
    @IBAction func nine(_ sender: AnyObject) {
        pressDown(number: "9")
    }
    
    @IBAction func eight(_ sender: AnyObject) {
        pressDown(number: "8")
    }
    
    @IBAction func seven(_ sender: AnyObject) {
        pressDown(number: "7")
    }
    
    @IBAction func six(_ sender: AnyObject) {
        pressDown(number: "6")
    }
    
    @IBAction func five(_ sender: AnyObject) {
        pressDown(number: "5")
    }
    
    @IBAction func four(_ sender: AnyObject) {
        pressDown(number: "4")
    }
    
    @IBAction func three(_ sender: AnyObject) {
        pressDown(number: "3")
    }
    
    @IBAction func two(_ sender: AnyObject) {
        pressDown(number: "2")
    }
    
    @IBAction func one(_ sender: AnyObject) {
        pressDown(number: "1")
    }
    
    @IBAction func zero(_ sender: AnyObject) {
        pressDown(number: "0")
    }
    
    @IBAction func nod(_ sender: AnyObject) {
        pressDown(number: ".")
    }
    
    @IBAction func add(_ sender: AnyObject) {
        pressDown(number: "+")
    }
    
    @IBAction func sub(_ sender: AnyObject) {
        pressDown(number: "-")
    }
    
    @IBAction func mul(_ sender: AnyObject) {
        pressDown(number: "*")
    }
    
    @IBAction func div(_ sender: AnyObject) {
        pressDown(number: "/")
    }
    
    @IBAction func leftParenthesis(_ sender: AnyObject) {
        pressDown(number: "(")
    }
    
    @IBAction func rightParenthesis(_ sender: AnyObject) {
        pressDown(number: ")")
    }
    
    @IBAction func index(_ sender: AnyObject) {
        pressDown(number: "^")
    }
    
    @IBAction func clear(_ sender: AnyObject) {
        register = ""
        memory = 0.0
        numStr = ""
        num.removeAll()
        char.removeAll()
        calculator.setCurrentSolution(temporarySolution: .none)
        Screen.text = ""
        flag = 0
        transform = 0
    }
    
    @IBAction func getResult(_ sender: AnyObject) {
        if(numStr == "" && ifParenthesis != ")")
        {
            occurError()
        }
        else
        {
            getNumber()
            if(Screen.text != "0 unable to be divided")
            {
                if(register == "")
                {
                    Screen.text = "0.0"
                }
                else
                {
                    playScreen()
                    computeTheResult()
                }
            }
            star = 1
        }
    }
    
    func computeIt()
    {
        var answer = ""
         length = num.count
         length2 = char.count
        if(char[length2-1] == "*")
        {
            if(num.count < 2)
            {
                occurError()
            }
            else
            {
                calculator.setCurrentSolution(temporarySolution: .mul)
                answer = calculator.getResult(operatorNum: num[length-2], operatoredNum: num[length-1])
                let temp = answer as NSString
                num[length-2] = temp.doubleValue
                num.remove(at: length-1)
                char.remove(at: length2-1)
                flag = 0
            }
        }
        else if(char[length2-1] == "/")
        {
            if(num.count < 2)
            {
                occurError()
            }
            else
            {
                calculator.setCurrentSolution(temporarySolution: .div)
                answer = calculator.getResult(operatorNum: num[length-2], operatoredNum: num[length-1])
                let temp = answer as NSString
                num[length-2] = temp.doubleValue
                num.remove(at: length-1)
                char.remove(at: length2-1)
                flag = 0
            }
        }
        else if(char[length2-1] == "^")
        {
            if(num.count < 2)
            {
                occurError()
            }
            else
            {
                calculator.setCurrentSolution(temporarySolution: .index)
                answer = calculator.getResult(operatorNum: num[length-2], operatoredNum: num[length-1])
                let temp = answer as NSString
                num[length-2] = temp.doubleValue
                num.remove(at: length-1)
                char.remove(at: length2-1)
                flag = 0
            }
        }
    }
    
    func solveParenthesis(){
        var length = num.count
        var length2 = char.count
        if(char.count == 0)
        {
            occurError()
            return
        }
        while(char.count != 0 && char[length2-1] != "(")
        {
            if(char.count == 0 || num.count < 2)
            {
                occurError()
                return
            }
            var answer = ""
            if(char[length2-1] == "+")
            {
                calculator.setCurrentSolution(temporarySolution: .add)
                answer = calculator.getResult(operatorNum: num[length-2], operatoredNum: num[length-1])
                let temp = answer as NSString
                num[length-2] = temp.doubleValue
                num.remove(at: length-1)
                char.remove(at: length2-1)
                length -= 1
                length2 -= 1
            }
            else if(char[length2-1] == "*")
            {
                calculator.setCurrentSolution(temporarySolution: .mul)
                answer = calculator.getResult(operatorNum: num[length-2], operatoredNum: num[length-1])
                let temp = answer as NSString
                num[length-2] = temp.doubleValue
                num.remove(at: length-1)
                char.remove(at: length2-1)
                length -= 1
                length2 -= 1
                flag = 0
            }
            else if(char[length2-1] == "/")
            {
                calculator.setCurrentSolution(temporarySolution: .div)
                answer = calculator.getResult(operatorNum: num[length-2], operatoredNum: num[length-1])
                let temp = answer as NSString
                num[length-2] = temp.doubleValue
                num.remove(at: length-1)
                char.remove(at: length2-1)
                length -= 1
                length2 -= 1
                flag = 0
            }
            else if(char[length2-1] == "^")
            {
                calculator.setCurrentSolution(temporarySolution: .index)
                answer = calculator.getResult(operatorNum: num[length-2], operatoredNum: num[length-1])
                let temp = answer as NSString
                num[length-2] = temp.doubleValue
                num.remove(at: length-1)
                char.remove(at: length2-1)
                length -= 1
                length2 -= 1
                flag = 0
            }
        }
        if(Screen.text != "The expression is wrong")
        {
            char.remove(at: length2-1)
        }
    }
    
    
    func getNumber()
    {
        if(pattern == 1)
        {
            if(numStr != "")
            {
                memory = (numStr as NSString).doubleValue
                numStr = ""
                num.append(memory * -1)
                pattern = 1
            }
            pattern = 0
        }
        else
        {
        if(numStr != "")
        {
            memory = (numStr as NSString).doubleValue
            numStr = ""
            if(transform == 1)
            {
                num.append(memory * -1)
                transform = 0
            }
            else
            {
                num.append(memory)
            }
        }
        if(num.count > 0 && char.count > 0 && num[num.count-1] == 0 && char[char.count-1] == "/")
        {
            Screen.text = "0 unable to be divided"
            memory = 0.0
            register = ""
            numStr = ""
            num.removeAll()
            char.removeAll()
            calculator.setCurrentSolution(temporarySolution: .none)
            flag = 0
            transform = 0
        }
        if flag == 1 {
            computeIt()
        }
        }
    }
    
    func playScreen()
    {
        Screen.text = register
    }
    
    func pressDown(number: String){
        if (star == 1)
        {
            register = ""
            memory = 0.0
            numStr = ""
            num.removeAll()
            char.removeAll()
            calculator.setCurrentSolution(temporarySolution: .none)
            Screen.text = ""
            flag = 0
            transform = 0
            star = 0
        }
        ifParenthesis = number
        switch (number) {
        case "9","8","7","6","5","4","3","2","1","0":
            numStr += number
            register += number
            playScreen()
        case ".":
            if(numStr == "")
            {
                register = "0."
                numStr = "0."
            }
            else
            {
                numStr += number
                register += number
            }
            playScreen()
        case "+":
            getNumber()
            char.append("+")
            register += number
            playScreen()
        case "-":
            if(char.count == 0)
            {
                if(register == "")
                {
                register += number
                playScreen()
                pattern = 1
                }
                else
                {
                    getNumber()
                    transform = 1
                    char.append("+")
                    register += number
                    playScreen()
                }
            }
            else if(help == "(")
            {
                register += number
                playScreen()
                pattern = 1
            }
            else
            {
                getNumber()
                transform = 1
                char.append("+")
                register += number
                playScreen()
            }
        case"*":
            getNumber()
            flag = 1
            char.append("*")
            register += number
            playScreen()
        case "/":
            getNumber()
            flag = 1
            char.append("/")
            register += number
            playScreen()
        case "(":
            flag = 0
            char.append("(")
            register += number
            playScreen()
            pattern = 0
        case ")":
            getNumber()
            if(Screen.text != "0 unable to be divided")
            {
                solveParenthesis()
                register += number
                playScreen()
            }
        case "^":
            getNumber()
            flag = 1
            char.append("^")
            register += number
            playScreen()
        default: register += number
        }
        help = number
    }
    
    func computeTheResult(){
        if(num.count < 2 && char.count > 0)
        {
            occurError()
            return
        }
        var answer = ""
        var length = num.count
        var length2 = char.count
        if (char.count >= 1){
            while(length > 1)
            {
                if(char[length2-1] == "+")
                {
                    if(num.count < 2)
                    {
                        occurError()
                        return
                    }
                    calculator.setCurrentSolution(temporarySolution: .add)
                    answer = calculator.getResult(operatorNum: num[length-2], operatoredNum: num[length-1])
                    let temp = answer as NSString
                    num[length-2] = temp.doubleValue
                    num.remove(at: length-1)
                    char.remove(at: char.count-1)
                    length -= 1
                    length2 -= 1
                }
                else if(char[length2-1] == "*")
                {
                    if(num.count < 2)
                    {
                        occurError()
                        return
                    }
                    calculator.setCurrentSolution(temporarySolution: .mul)
                    answer = calculator.getResult(operatorNum: num[length-2], operatoredNum: num[length-1])
                    let temp = answer as NSString
                    num[length-2] = temp.doubleValue
                    num.remove(at: length-1)
                    char.remove(at: char.count-1)
                    length -= 1
                    length2 -= 1
                    flag = 0
                }
                else if(char[length2-1] == "/")
                {
                    if(num.count < 2)
                    {
                        occurError()
                        return
                    }
                    calculator.setCurrentSolution(temporarySolution: .div)
                    answer = calculator.getResult(operatorNum: num[length-2], operatoredNum: num[length-1])
                    let temp = answer as NSString
                    num[length-2] = temp.doubleValue
                    num.remove(at: length-1)
                    char.remove(at: length2-1)
                    length -= 1
                    length2 -= 1
                    flag = 0
                }
                else if(char[length2-1] == "^")
                {
                    if(num.count < 2)
                    {
                        occurError()
                        return
                    }
                    calculator.setCurrentSolution(temporarySolution: .index)
                    answer = calculator.getResult(operatorNum: num[length-2], operatoredNum: num[length-1])
                    let temp = answer as NSString
                    num[length-2] = temp.doubleValue
                    num.remove(at: length-1)
                    char.remove(at: char.count-1)
                    length -= 1
                    length2 -= 1
                    flag = 0
                }
            }
        }
        if(Screen.text != "The expression is wrong")
        {
            if (Screen.text != "0 unable to be divided")
            {
                if(num.count == 0)
                {
                    occurError()
                }
                else
                {
                    register = "\(num[0])"
                    Screen.text = register
                }
            }
            else {
                Screen.text = register
            }
        }
    }
    
    func occurError(){
        register = ""
        memory = 0.0
        numStr = ""
        num.removeAll()
        char.removeAll()
        calculator.setCurrentSolution(temporarySolution: .none)
        Screen.text = "The expression is wrong"
        flag = 0
        transform = 0
        star = 0

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
