//
//  House.swift
//  Westeros
//
//  Created by Brais Moure on 8/2/18.
//  Copyright © 2018 Brais Moure. All rights reserved.
//

import UIKit

typealias Words = String
typealias Members = Set<Person>

// MARK: - House types
enum HouseName: String {
    case baratheon, bolton, florent, lannister, martell, redwyne, stark, umber, targaryen, tully
}

// MARK: - House
final class House {
    
    let name: String
    let sigil: Sigil
    let words: Words
    let wikiUrl: URL
    private var _members: Members
    
    init(name: String, sigil: Sigil, words: Words, url: URL) {
        self.name = name
        self.sigil = sigil
        self.words = words
        self.wikiUrl = url
        _members = Members()
    }
    
}

extension House {
    
    var count: Int {
        return _members.count
    }
    
    var sortedMembers: [Person] {
        return _members.sorted()
    }
    
    func add(person: Person) {
        guard person.house == self else {
            return
        }
        _members.insert(person)
    }
    
    func add(persons: Person...) {
        // Aquí, persons es de tipo [Person]
        /*for person in persons {
            add(person: person)
        }*/
        persons.forEach{ add(person: $0) }
    }
    
}

// MARK: - Proxy
extension House {
    var proxyForEquality: String {
        return "\(name) \(words) \(count)"
    }
    
    var proxyForComparison: String {
        return name.uppercased()
    }
}

// MARK: - Equatable
extension House: Equatable {
    static func ==(lhs: House, rhs: House) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

// MARK: - Hashable
extension House: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

// MARK: - Comparable
extension House: Comparable {
    static func <(lhs: House, rhs: House) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}

// MARK: - Sigil
final class Sigil {
    
    let image: UIImage
    let description: String
    
    init(image: UIImage, description: String) {
        self.image = image
        self.description = description
    }
    
}
