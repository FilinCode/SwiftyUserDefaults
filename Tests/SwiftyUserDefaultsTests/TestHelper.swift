import SwiftyUserDefaults

struct FrogCodable: Codable {

    let name: String

    init(name: String = "Froggy") {
        self.name = name
    }
}

struct FrogSerializable: DefaultsSerializable {

    let name: String

    init(name: String = "Froggy") {
        self.name = name
    }

    static func get(key: String, userDefaults: UserDefaults) -> FrogSerializable? {
        NSLog("Custom get for FrogSerializable")
        let name = userDefaults.object(forKey: key) as? String

        return name.map(FrogSerializable.init)
    }

    static func save(key: String, value: FrogSerializable?, userDefaults: UserDefaults) {
        NSLog("Custom save for FrogSerializable")
        guard let value = value else {
            return userDefaults.removeObject(forKey: key)
        }
        userDefaults.set(value.name, forKey: key)
    }
}

struct FrogCodableSerializable: Codable, DefaultsGettable, DefaultsStoreable {

    let name: String

    init(name: String = "Froggy") {
        self.name = name
    }

    static func get(key: String, userDefaults: UserDefaults) -> FrogCodableSerializable? {
        NSLog("Custom get for FrogCodableSerializable")
        let name = userDefaults.object(forKey: key) as? String

        return name.map(FrogCodableSerializable.init)
    }

    static func save(key: String, value: FrogCodableSerializable?, userDefaults: UserDefaults) {
        NSLog("Custom save for FrogCodableSerializable")
        guard let value = value else {
            return userDefaults.removeObject(forKey: key)
        }
        userDefaults.set(value.name, forKey: key)
    }
}

extension DefaultsKeys {
    // Optional DefaultSerializable support with default values and without
    static let abc1 = DefaultsKey<FrogCodableSerializable?>("h1", defaultValue: FrogCodableSerializable())
    static let abc2 = DefaultsKey<FrogCodableSerializable?>("h2", defaultValue: nil)
    static let abc3 = DefaultsKey<FrogCodableSerializable?>("h3")

    // DefaultSerializable support with default values
    static let abc4 = DefaultsKey<FrogCodableSerializable>("h4", defaultValue: FrogCodableSerializable())
    //    static let abc5 = DefaultsKey<FrogCodableSerializable>("h5") // error here, you won't be able to instantiate a non-optional value without defaultValue parameter


    // Optional Codable support with default values and without
    static let abc6 = DefaultsCodableKey<FrogCodable?>("h6", defaultValue: FrogCodable())
    static let abc7 = DefaultsCodableKey<FrogCodable?>("h7", defaultValue: nil)
    static let abc8 = DefaultsCodableKey<FrogCodable?>("h8")


    // Codable support with default values
    static let abc9 = DefaultsCodableKey<FrogCodable>("h9", defaultValue: FrogCodable())
    //    static let abc10 = DefaultsCodableKey<FrogCodable>("h10") // error here as well as in the DefaultsSerializable


    // Built-in types with default values
    static let abc11 = DefaultsKey<String>("h11")
    static let abc12 = DefaultsKey<Bool>("h12")
    static let abc13 = DefaultsKey<Double>("h13")
    static let abc14 = DefaultsKey<Int>("h14")
    static let abc15 = DefaultsKey<Data>("h15")


    // Built-in serializable types without default values (need to provide them by parameter or extension to type)
    //    static let abc16 = DefaultsKey<Date>("h16")
    //    static let abc17 = DefaultsKey<URL>("h17")



    static let abc18 = DefaultsKey<Date>("h18", defaultValue: Date())
}

//#if os(OSX)
//    import Cocoa
//#else
//    import UIKit
//    typealias NSColor = UIColor
//#endif
//
//import SwiftyUserDefaults
//
//extension UserDefaults {
//    subscript(key: DefaultsKey<NSColor?>) -> NSColor? {
//        get { return unarchive(key) }
//        set { archive(key, newValue) }
//    }
//    
//    subscript(key: DefaultsKey<NSColor>) -> NSColor {
//        get { return unarchive(key) ?? .white }
//        set { archive(key, newValue) }
//    }
//    
//    subscript(key: DefaultsKey<[NSColor]>) -> [NSColor] {
//        get { return unarchive(key) ?? [] }
//        set { archive(key, newValue) }
//    }
//}
//
//enum TestEnum: String {
//    case A, B, C
//}
//
//extension UserDefaults {
//    subscript(key: DefaultsKey<TestEnum?>) -> TestEnum? {
//        get { return unarchive(key) }
//        set { archive(key, newValue) }
//    }
//}
//
//extension UserDefaults {
//    subscript(key: DefaultsKey<TestEnum>) -> TestEnum {
//        get { return unarchive(key) ?? .A }
//        set { archive(key, newValue) }
//    }
//}
//
//enum TestEnum2: Int {
//    case ten = 10
//    case twenty = 20
//    case thirty = 30
//}
//
//extension UserDefaults {
//    subscript(key: DefaultsKey<TestEnum2?>) -> TestEnum2? {
//        get { return unarchive(key) }
//        set { archive(key, newValue) }
//    }
//}
