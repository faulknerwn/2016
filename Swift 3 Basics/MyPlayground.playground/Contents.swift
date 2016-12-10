//: Playground - noun: a place where people can play

import UIKit


class Car {
    let numWheels: Int
    init(numWheels: Int) {
        self.numWheels = numWheels
    }
}


class familyCar: Car {
    let numDoors = 5
}

class bigFamilyCar: familyCar {
    var size = "Large"
}
var myFamilyCar = familyCar(numWheels: 6)
myFamilyCar.numWheels
myFamilyCar.numDoors






class fastCar {
    
    var topSpeed: Int
    
    init (topSpeed: Int) {
        self.topSpeed = topSpeed
    }
    func getTopSpeed () -> Int {
        return self.topSpeed
    }
}

var myCar = fastCar(topSpeed: 210)
myCar.getTopSpeed()


var ferrari = fastCar(topSpeed: 250)
ferrari.getTopSpeed()












func checkCount (message: String, cunt: Int) -> String {

    var count2: Int = cunt
    while count2 < 10 {
        print(message)
        count2+=1
    }
    return "Done!"
}

checkCount(message: "hello", cunt:3)
checkCount(message: "test", cunt:6)


var myTest: String?
print(myTest)
if let myTestVal = myTest {
    var newTest = myTestVal + "suffix"
}


for var i in 0..<10 {
    print(i)
}


var numbers: [Int] = [4,5,22,333,12]
for var n in numbers {
    print(n)
    
}

var count = 0
repeat {
    print("not yet")
    count+=1

}
while count < 20





var someInts: [Int] = [5,9,22,11]
var someStrings = [String] ()

someInts.append(4)
someStrings.append("wendy")

someInts += [6,8]


someInts.count
print(someInts.count)
print(someInts[2])

var letters = Set<Character>()
letters.insert("a")

var favs: Set = ["Pizza", "Wine", "Beer", "Wine"]

//Dictionary<Key, Value>

var namesOfIntegers = [Int: String] ()


namesOfIntegers[2] = "two"
namesOfIntegers[7] = "seven"
var names = [Int: [String]] ()

names[2] = ["two", "dvah"]
//: print(names[2]?[1])

var myNum = 47

if (myNum == 46) {
    print(myNum)
}
else if (myNum > 46) {
print("old woman")
}
else {
    print("youngster")
}

switch myNum {
case 46:
        print(myNum)
case 0..<46:
    print("youngster")
default:
    print("old")
}
