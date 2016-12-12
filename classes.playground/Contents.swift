//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Person {
    
    var name = ""
    var age = 0
    var weight = 0
    
    func info() {
    print("This person's name is \(name) and they are \(age) years old")
    }
}

var person1 = Person()
person1.name = "Wendy"
person1.age = 46
person1.weight = 144

var person2 = Person()
person2.name = "Bob"

print(person1.name)

var people = [person1,person2]
people[1].name



person1.info()
