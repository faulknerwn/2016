//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var newstring = str + " rob!"

for character in newstring.characters {
    print(character)
    
}

let newTypeString = NSString(string: newstring)
newTypeString.substring(to: 5)
newTypeString.substring(from: 4)
NSString(string:newTypeString.substring(from: 18)).substring(to: 3)

newTypeString.substring(with: NSRange(location: 18, length: 3))

if newTypeString.contains("rob") {
    print("yes")
    
}


newTypeString.components(separatedBy: " ")

newTypeString.uppercased
newTypeString.lowercased

