//
//  EpisodeTest.swift
//  WesterosTests
//
//  Created by Brais Moure on 3/3/18.
//  Copyright © 2018 Brais Moure. All rights reserved.
//

import XCTest
@testable import Westeros

class EpisodeTest: XCTestCase {
    
    var s1e1: Episode!
    var s1e2: Episode!
    
    override func setUp() {
        super.setUp()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Creación de temporadas
        let seasonOne = Season(title: "Season 1", releaseDate: dateFormatter.date(from: "2011-04-17")!)
        
        // Episodios por temporada
        s1e1 = Episode(title: "Winter Is Coming", releaseDate: dateFormatter.date(from: "2011-04-17")!, season: seasonOne, video: URL(string: "https://youtube.com/embed/BpJYNVhGf1s"))
        s1e2 = Episode(title: "The Kingsroad", releaseDate: dateFormatter.date(from: "2011-04-24")!, season: seasonOne, video: URL(string: "https://youtube.com/embed/kPrW3Swrp4E"))
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testString() {
        XCTAssertNotNil(s1e1.description)
    }
    
    func testEquality() {
        // Identidad
        XCTAssertEqual(s1e1, s1e1)
        
        // Igualdad
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let seasonOne = Season(title: "Season 1", releaseDate: dateFormatter.date(from: "2011-04-17")!)
        let jinxed = Episode(title: "Winter Is Coming", releaseDate: dateFormatter.date(from: "2011-04-17")!, season: seasonOne, video: URL(string: "https://youtube.com/embed/BpJYNVhGf1s"))
        XCTAssertEqual(jinxed, s1e1)
        
        // Desigualdad
        XCTAssertNotEqual(s1e1, s1e2)
    }
    
    func testHashable() {
        XCTAssertNotNil(s1e1.hashValue)
    }
    
    func testComparable() {
        XCTAssertLessThan(s1e1, s1e2)
    }
    
}
