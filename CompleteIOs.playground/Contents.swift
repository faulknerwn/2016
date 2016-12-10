//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
print ("wendy")
var myInt = 8
print(myInt * 2)
myInt = myInt / 5
print("myInt has value \(myInt)")
var myName = "Wendy"
var myAge = 46
print("\(myName) is \(myAge)")
print("My name is " + myName + " and I am \(myAge) years old")

var a: Double = 8.73
var b: Float = 1.722
var c = 2.11

print (a/c)
print (Double(myInt) + a)

let gameOver = false
var gameOverString = String(gameOver)

var dd:Double = 5.76
var ee:Int = 8
var total = Double(ee) * dd
print ("The product of \(dd) and \(ee) is \(dd * Double(ee))")





var array = [33,22,11,222]
print(array[0])
array.append(1)
array.remove(at:1)
array.sort()
print(array)


var test = [3.87,7.1,8.9]
test.remove(at:1)
test.append(test[0]*test[1])

var dictionary = ["computer": "something", "coffee": "drink"]
print(dictionary["computer"])

dictionary.count

dictionary.removeValue(forKey: "computer")

var menu = ["pizza": 10.99, "ice cream": 4.99, "salad": 7.99]

print("The total cost of my meal is:", menu["pizza"]! + menu["salad"]!  )

let username = "wendy"
let password = "password"



