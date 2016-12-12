//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func hello() {
    print("hello world")
}

func printItOut(word : String) {
    print(word)
}

hello()

printItOut(word: "test")

func addTwo(num1:Int, num2:Int) -> Int {
    return(num1+num2)
}
addTwo(num1:5, num2:8)

func personInfo(name:String,age:Int,weight:Double) -> String {
    return "My name is \(name) I am \(age) years old and weigh \(weight) lbs"
}
personInfo(name:"Wendy",age:46,weight:145)
