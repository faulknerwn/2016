//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let diceRoll = arc4random_uniform(6)

var i = 1

while i < 10 {
    print(i)
    i += 1
}
i = 1

while i < 20 {
    print(i*7)
    i += 1
    
}

var array = [7,10,22,33,46,88]

i = array.count

var j = 0
while j < i {
    array[j] = array[j] + 1
    print(array[j])
    j += 1
}

for number in array {
    print(number)
}
var names = ["Mark","Penny","Cheri","Bob"]
for name in names {
    print("Hi " + name)
}

var numbers = [7, 2, 9, 4, 1]
for (index,value) in numbers.enumerated() {
    numbers[index] += 1
    
}
print(numbers)

var list = [Double]()
list = [8.0,7.0,19.0,28.0]

for (index, value) in list.enumerated() {
   list[index] = value/2
}
print(list)