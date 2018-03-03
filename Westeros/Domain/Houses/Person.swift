//
//  Character.swift
//  Westeros
//
//  Created by Brais Moure on 8/2/18.
//  Copyright © 2018 Brais Moure. All rights reserved.
//

import UIKit

class Person {
    
    let name: String
    let house: House
    private let _alias: String? // Hay una convencion que dice que las propiedades privadas empiezan por _
    
    var alias: String {
        return _alias ?? ""
    }
    
    init(name: String, alias: String? = nil, house: House) {
        self.name = name
        _alias = alias
        self.house = house
        
        // Se añade el personaje a su casa
        self.house.add(person: self)
    }
    
    /*convenience init(name: String, house: House) {
        self.init(name: name, alias: nil, house: house)
    }*/
    
}

extension Person {
    
    var fullName: String {
        return "\(name) \(house.name)"
    }
    
}

// MARK: - Proxies
extension Person {
    
    var proxyForEquality: String {
        return "\(name) \(alias) \(house.name)"
    }
    
    var proxyForComparison: String {
        return fullName
    }
    
}

// MARK: - Hashable
extension Person: Hashable {
    
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
    
}

// MARK: - Equatable
extension Person: Equatable {
    
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
    
}

// MARK: - Comparable
extension Person: Comparable {
    
    static func <(lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }    

}
