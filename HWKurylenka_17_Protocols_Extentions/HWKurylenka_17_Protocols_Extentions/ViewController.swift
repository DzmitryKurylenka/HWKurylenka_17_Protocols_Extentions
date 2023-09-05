//
//  ViewController.swift
//  HWKurylenka_17_Protocols_Extentions
//
//

import Foundation

// Protocols

protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

// ---

struct SomeStruct: SomeProtocol {
    var mustBeSettable: Int
    let doesNotNeedToBeSettable: Int
    // дополнительный метод, не описанный в протоколе
    func getSum() -> Int {
        return self.mustBeSettable + self.doesNotNeedToBeSettable
    }
}

// ---

protocol AnotherProtocol {
    static var someTypeProperty: Int { get }
}

// ---

struct AnotherStruct: SomeProtocol, AnotherProtocol {
    var mustBeSettable: Int
    let doesNotNeedToBeSettable: Int
    static var someTypeProperty: Int = 3
    func getSum() -> Int {
        return self.mustBeSettable
        + self.doesNotNeedToBeSettable
        + AnotherStruct.someTypeProperty
    }
}

// ---

protocol RandomNumberGenerator {
    var randomCollection: [Int] { get set }
    func getRandomNumber() -> Int
    mutating func setNewRandomCollection(newValue: [Int])
}

// ---

struct RandomGenerator: RandomNumberGenerator {
    var randomCollection: [Int] = [1,2,3,4,5]
    func getRandomNumber() -> Int {
        return randomCollection.randomElement() ?? 0
    }
    mutating func setNewRandomCollection(newValue: [Int]) {
            self.randomCollection = newValue
        }
    }
class RandomGeneratorClass: RandomNumberGenerator {
    var randomCollection: [Int] = [1,2,3,4,5]
    func getRandomNumber() -> Int {
        if let randomElement = randomCollection.randomElement() {
            return randomElement
        }
return 0 }
    // не используется модификатор mutating
    func setNewRandomCollection(newValue: [Int]) {
        self.randomCollection = newValue
    }
}

// ---

protocol Named {
    init(name: String)
}
class Person: Named {
    var name: String
    required init(name: String) {
        self.name = name
    }
}

// ---

func getHash<T: Hashable>(of value: T) -> Int {
    return value.hashValue
}

func main10() {
    let intHash = getHash(of: 5)
    let stringHash = getHash(of: "Swift")

    print("Hash of Int: \(intHash)")
    print("Hash of String: \(stringHash)")
}

// ---

protocol HasValue {
    var value: Int { get set }
}
class ClassWithValue: HasValue {
    var value: Int
    init(value: Int) {
        self.value = value
    }
}
struct StructWithValue: HasValue {
    var value: Int
}
// коллекция элементов
let objects: [Any] = [
    2,
    StructWithValue(value: 3),
    true,
    ClassWithValue(value: 6),
    "Usov"
]

func main11() {
    for object in objects {
        if let elementWithValue = object as? HasValue {
            print("Значение \(elementWithValue.value)")
        }
    }
}

func main12() {
    for object in objects {
        print(object is HasValue)
    }
}


// ---

protocol GeometricFigureWithXAxis {
    var x: Int { get set }
}
protocol GeometricFigureWithYAxis {
    var y: Int { get set }
}
protocol GeometricFigureTwoAxis: GeometricFigureWithXAxis,
GeometricFigureWithYAxis {
    var distanceFromCenter: Float { get }
}
struct Figure2D: GeometricFigureTwoAxis {
    var x: Int = 0
    var y: Int = 0
    var distanceFromCenter: Float {
        let xPow = pow(Double(self.x), 2)
        let yPow = pow(Double(self.y), 2)
        let length = sqrt(xPow + yPow)
        return Float(length)
    }
}

// ---

protocol Named1 {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct Person1: Named1, Aged {
    var name: String
    var age: Int
}

func wishHappyBirthday(celebrator: Named1 & Aged) {
    print("С Днем рождения, \(celebrator.name)! Тебе уже \(celebrator.age)!")
}

func main13() {
    let birthdayPerson = Person1(name: "Джон Уик", age: 46)
    wishHappyBirthday(celebrator: birthdayPerson)
}

// Extension

extension Double {
    var asKM: Double { return self / 1000.0 }
    var asM: Double { return self }
    var asCM: Double { return self * 100.0 }
    var asMM: Double { return self * 1000.0 }
}

func main() {
    let length: Double = 25
    let km = length.asKM
    let mm = length.asMM

    print("Length in kilometers: \(km)")
    print("Length in millimeters: \(mm)")
}

// ---

extension Double {
    var asFT: Double {
        get {
            return self / 0.3048
        }
        set(newValue) {
            self = newValue * 0.3048
        }
    }
}

func calculateDistance() {
    var distance: Double = 100
    let feetValue = distance.asFT
    print("Distance in feet: \(feetValue)")
    
    distance.asFT = 150
    print("Updated distance in meters: \(distance)")
}

// ---

extension Int {
    func repetitions(task: () -> ()) {
        for _ in 0..<self {
            task()
        }
    }
}

func main1() {
    let number = 3
    number.repetitions {
        print("Swift")
    }
}

// ---

extension Int {
    mutating func squared() {
        self = self * self
    }
}

func main2() {
    var someInt = 3
    someInt.squared()
    print(someInt)
}

// ---

struct Line {
    var pointOne: (Double, Double)
    var pointTwo: (Double, Double)
}
extension Double {
    init(line: Line) {
        self = sqrt(
            pow((line.pointTwo.0 - line.pointOne.0), 2) +
            pow((line.pointTwo.1 - line.pointOne.1), 2)
        )
    }
}
var myLine = Line(pointOne: (10,10), pointTwo: (14,10))
var lineLength = Double(line: myLine) // 4

// ---

extension Int {
    subscript(digitIndex: Int) -> Int {
        var base = 1
        var index = digitIndex
        while index > 0 {
            base *= 10
            index -= 1
        }
        return (self / base) % 10
    }
}

func main3() {
    let number = 746381295
    print(number[0]) // Выводит цифру 7
    print(number[1]) // Выводит цифру 4
}

// ---

protocol TextRepresentable {
    func asText() -> String
}

extension Int: TextRepresentable {
    func asText() -> String {
        return String(self)
    }
}

func main4() {
    let number: Int = 5
    let text = number.asText() // 5
    print(text)
}

// ---

protocol Descriptional {
    func getDescription() -> String
}

extension Descriptional {
    func getDescription() -> String {
        return "Описание объектного типа"
    }
}

class myClass: Descriptional {}

func main5() {
    print(myClass().getDescription())
}

// ---

class MyStruct: Descriptional {
    func getDescription() -> String {
        return "Описание структуры"
    }
}

func main6() {
    let myInstance = MyStruct()
    let description = myInstance.getDescription()
    print(description)
}

// ---

extension TextRepresentable {
    func about() -> String {
        return "Данный тип поддерживает протокол TextRepresentable"
    }
}

func main7() {
    let number: Int = 5
    let text = number.about()
    print(text)
}





