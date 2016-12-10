//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Ghost {
    
    var isAlive = true
    var strength = 9
    func kill() {
        isAlive = false
    }
    func isStrong() -> Bool {
        if strength > 10 {
            return true
        }
        else {
            return false
        }
    }
}

var ghost = Ghost()
print (ghost.isAlive)
ghost.strength = 20
ghost.kill()
print(ghost.isAlive)
print (ghost.isStrong())



var number: Int?
print(number)

let userEnteredText = "Theee"
let userEnteredInteger = Int(userEnteredText)
if let something = userEnteredInteger {
    print (something*7)
    
}