//: [Previous](@previous)

import Foundation

let myTuple = (10, 432.433, "This is a String")
let myString = myTuple.2

let (myInt, myDouble, _) = myTuple
print(myDouble)

let aSecondTuple = (count: 12, length: 123.345, message: "Why not?")

print(aSecondTuple.0)
print(aSecondTuple.count)


let temperature = 11
switch (temperature)
{
      case 0...49:
        print("Cold and even")
        fallthrough
      case 50...79 where temperature % 2 == 0:
        print("Warm and even")
        fallthrough
      case 80...110 where temperature % 2 == 0:
        print("Hot and even")
        fallthrough
      default:
        print("Temperature out of range or odd")
}

//: [Next](@next)
