//
//  ViewController.swift
//  dentaku
//
//  Created by 澤田昂明 on 2018/09/16.
//  Copyright © 2018年 澤田昂明. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var num: Int = 0
    
    var viewString: String = ""
    
    var numArray:[Int] = []
    var fugoArray:[String] = []
    
    @IBOutlet var label:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func number(_ sender:UIButton){
        let number = sender.tag
        num = num * 10 + number
        
        viewString = viewString+String(number)
        label.text = viewString
    }
    
    
    @IBAction func fugou(_ sender: UIButton){
        
        if numArray.count - fugoArray.count == 0{
            //numを追加する
            numArray.append(num)
            num = 0
            
            switch sender.tag {
            case 11:
                fugoArray.append("+")
            case 12:
                fugoArray.append("-")
            case 13:
                fugoArray.append("*")
            case 14:
                fugoArray.append("/")
            default:
                break
            }
            
            viewString = viewString+fugoArray.last!
            label.text = viewString
        }
        
    }
    
    @IBAction func equal(){
        //numを追加する
        numArray.append(num)
        num = 0
        //差が1のときたけ実行する
        if numArray.count - fugoArray.count == 1{
            
            while fugoArray.count > 0{
                let indexOfPrime = searchPrimeFunc(funcs: fugoArray)
                let tempResult = caliculate(num1: numArray[indexOfPrime], num2: numArray[indexOfPrime+1], fun: fugoArray[indexOfPrime])
                
                //計算に使用したものを全て削除
                fugoArray.remove(at: indexOfPrime)
                numArray.remove(at: indexOfPrime)
                numArray.remove(at: indexOfPrime)
                
                //結果を挿入する．
                numArray.insert(tempResult, at: indexOfPrime)
            }
            
            viewString = viewString + "=" + String(numArray[0])
            label.text = viewString
            
        }else{
            print("入力に誤りがあります．")
        }
        
        reset()
    }
    
    @IBAction func ac(){
        reset()
        label.text = "0"
    }
    
    //計算を行う
    func caliculate(num1:Int, num2:Int, fun:String) -> Int{
        switch fun {
        case "+":
            return num1 + num2
        case "-":
            return num1 - num2
        case "*":
            return num1 * num2
        case "/":
            return num1 / num2
        default:
            return 0
        }
    }
    
    //何個めに"*"と"/"が含まれているかを算出
    func searchPrimeFunc(funcs:[String]) -> Int{
        for i in 0..<funcs.count{
            if (funcs[i] == "*" || funcs[i] == "/"){
                return i
            }
        }
        return 0
    }
    
    func reset(){
        viewString = ""
        numArray = []
        fugoArray = []
        num = 0
    }
    
    
    
}

