//
//  SeasonTest.swift
//  WesterosTests
//
//  Created by Brais Moure on 3/3/18.
//  Copyright © 2018 Brais Moure. All rights reserved.
//

import XCTest
@testable import Westeros

class SeasonTest: XCTestCase {
    
    var seasonOne: Season!
    var seasonTwo: Season!
        
    override func setUp() {
        super.setUp()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Creación de temporadas
        seasonOne = Season(title: "Season 1", releaseDate: dateFormatter.date(from: "2011-04-17")!)
        seasonTwo = Season(title: "Season 2", releaseDate: dateFormatter.date(from: "2012-04-01")!)
        
        // Episodios por temporada
        let s1e1 = Episode(title: "Winter Is Coming", releaseDate: dateFormatter.date(from: "2011-04-17")!, season: seasonOne, video: URL(string: "https://youtube.com/embed/BpJYNVhGf1s"))
        let s1e2 = Episode(title: "The Kingsroad", releaseDate: dateFormatter.date(from: "2011-04-24")!, season: seasonOne, video: URL(string: "https://youtube.com/embed/kPrW3Swrp4E"))
        let s1e3 = Episode(title: "Lord Snow", releaseDate: dateFormatter.date(from: "2011-05-01")!, season: seasonOne, video: URL(string: "https://youtube.com/embed/68KrOZgmXZw"))
        let s1e4 = Episode(title: "Cripples, Bastards, and Broken Things", releaseDate: dateFormatter.date(from: "2011-05-08")!, season: seasonOne, video: URL(string: "https://youtube.com/embed/I2QwUIA8Puk"))
        let s1e5 = Episode(title: "The Wolf and the Lion", releaseDate: dateFormatter.date(from: "2011-05-15")!, season: seasonOne, video: URL(string: "https://youtube.com/embed/EzM_TQqlY3w"))
        let s1e6 = Episode(title: "A Golden Crown", releaseDate: dateFormatter.date(from: "2011-05-22")!, season: seasonOne, video: URL(string: "https://youtube.com/embed/NMQb7TQ4Y-A"))
        let s1e7 = Episode(title: "You Win or You Die", releaseDate: dateFormatter.date(from: "2011-05-29")!, season: seasonOne, video: URL(string: "https://youtube.com/embed/Q9tD6m254iY"))
        let s1e8 = Episode(title: "The Pointy End", releaseDate: dateFormatter.date(from: "2011-06-05")!, season: seasonOne, video: URL(string: "https://youtube.com/embed/w3AuxJPSk0c"))
        let s1e9 = Episode(title: "Baelor", releaseDate: dateFormatter.date(from: "2011-06-12")!, season: seasonOne, video: URL(string: "https://youtube.com/embed/_yE5h0cZgds"))
        let s1e10 = Episode(title: "Fire and Blood", releaseDate: dateFormatter.date(from: "2011-06-19")!, season: seasonOne, video: URL(string: "https://youtube.com/embed/zBO6fplbTS0"))
        seasonOne.add(episodes: s1e5, s1e6, s1e7, s1e8, s1e9, s1e10, s1e1, s1e2, s1e3, s1e3, s1e4) // Episodios desordenados (Season posee una operación sortedEpisodes)
        
        let s2e1 = Episode(title: "The North Remembers", releaseDate: dateFormatter.date(from: "2012-04-01")!, season: seasonTwo, video: URL(string: "https://youtube.com/embed/jn3FQMUgbxw"))
        let s2e2 = Episode(title: "The Night Lands", releaseDate: dateFormatter.date(from: "2012-04-08")!, season: seasonTwo)
        seasonTwo.add(episodes: s2e1, s2e2)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testString() {
        XCTAssertNotNil(seasonOne.description)
    }
    
    func testEquality() {
        // Identidad
        XCTAssertEqual(seasonOne, seasonOne)
        
        // Igualdad
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let jinxed = Season(title: "Season 2", releaseDate: dateFormatter.date(from: "2012-04-01")!)
        let s2e1 = Episode(title: "The North Remembers", releaseDate: dateFormatter.date(from: "2012-04-01")!, season: jinxed, video: URL(string: "https://youtube.com/embed/jn3FQMUgbxw"))
        let s2e2 = Episode(title: "The Night Lands", releaseDate: dateFormatter.date(from: "2012-04-08")!, season: jinxed)
        jinxed.add(episodes: s2e1, s2e2)
        XCTAssertEqual(jinxed, seasonTwo)
        
        // Desigualdad
        XCTAssertNotEqual(seasonOne, seasonTwo)
    }
    
    func testHashable() {
        XCTAssertNotNil(seasonOne.hashValue)
    }
    
    func testComparable() {
        XCTAssertLessThan(seasonOne, seasonTwo)
    }
    
}
