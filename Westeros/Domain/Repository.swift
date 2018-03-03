//
//  Repository.swift
//  Westeros
//
//  Created by Brais Moure on 13/2/18.
//  Copyright © 2018 Brais Moure. All rights reserved.
//

import Foundation

final class Repository {
    static let local = LocalFactory()    
}

protocol HouseFactory {
    typealias HouseFilter = (House) -> Bool
    var houses: [House] { get }
    func house(named: String) -> House?
    func house(named: HouseName) -> House?
    func houses(filteredBy: HouseFilter) -> [House]
}

protocol SeasonFactory {
    typealias SeasonFilter = (Season) -> Bool
    var seasons: [Season] { get }
    
    func seasons(filteredBy: SeasonFilter) -> [Season]
}

final class LocalFactory: HouseFactory, SeasonFactory {
  
    // MARK: - Houses
    
    var houses: [House] {
        
        // Houses creation here
        let starkSigil = Sigil(image: #imageLiteral(resourceName: "codeIsComing.png"), description: "Lobo Huargo")
        let lannisterSigil = Sigil(image: #imageLiteral(resourceName: "lannister.jpg"), description: "León Rampante")
        let targaryenSigil = Sigil(image: #imageLiteral(resourceName: "targaryenSmall.jpg"), description: "Dragón Tricéfalo")
        
        let starkHouse = House(name: "Stark", sigil: starkSigil, words: "Se acerca el invierno", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!)
        let lannisterHouse = House(name: "Lannister", sigil: lannisterSigil, words: "Oye mi rugido", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!)
        let targaryenHouse = House(name: "Targaryen", sigil: targaryenSigil, words: "Fuego y Sangre", url: URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!)
        
        let _ = Person(name: "Robb", alias: "El Joven Lobo", house: starkHouse)
        let _ = Person(name: "Arya", house: starkHouse)
        
        let _ = Person(name: "Tyrion", alias: "El Enano", house: lannisterHouse)
        let _ = Person(name: "Cersei", house: lannisterHouse)
        let _ = Person(name: "Jaime", alias: "El Matarreyes", house: lannisterHouse)
        
        let _ = Person(name: "Daenerys", alias: "Madre de Dragones", house: targaryenHouse)
        
        // Add characters to houses
        
        // Con la nueva implementación de Person, al indicar la casa de un personaje, ya se actualiza su lista de miembros
        //starkHouse.add(person: robb)
        //starkHouse.add(person: arya)
        //lannisterHouse.add(person: tyrion)
        //lannisterHouse.add(person: cersei)
        //lannisterHouse.add(person: jaime)
        //targaryenHouse.add(person: dany)
        
        return [starkHouse, lannisterHouse, targaryenHouse].sorted()
    }
    
    func house(named name: String) -> House? {
        return houses.filter{ $0.name.uppercased() == name.uppercased() }.first
        // return houses.first{ $0.name.uppercased() == name.uppercased() } Sería lo mismo cogiendo directamente el primero
    }
    
    func house(named: HouseName) -> House? {
        return house(named: named.rawValue)
    }
    
    func houses(filteredBy: HouseFilter) -> [House] {
        return houses.filter(filteredBy)
    }
    
    // MARK: - Seasons
    
    var seasons: [Season] {
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Creación de temporadas
        let seasonOne = Season(title: "Season 1", releaseDate: dateFormatter.date(from: "2011-04-17")!)
        let seasonTwo = Season(title: "Season 2", releaseDate: dateFormatter.date(from: "2012-04-01")!)
        let seasonThree = Season(title: "Season 3", releaseDate: dateFormatter.date(from: "2013-03-31")!)
        let seasonFour = Season(title: "Season 4", releaseDate: dateFormatter.date(from: "2014-04-06")!)
        let seasonFive = Season(title: "Season 5", releaseDate: dateFormatter.date(from: "2015-04-12")!)
        let seasonSix = Season(title: "Season 6", releaseDate: dateFormatter.date(from: "2016-04-24")!)
        let seasonSeven = Season(title: "Season 7", releaseDate: dateFormatter.date(from: "2017-07-16")!)
        
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
        
        let s3e1 = Episode(title: "Valar Dohaeris", releaseDate: dateFormatter.date(from: "2013-03-31")!, season: seasonThree, video: URL(string: "https://youtube.com/embed/1iTg20x7w2s"))
        let s3e2 = Episode(title: "Dark Wings, Dark Words", releaseDate: dateFormatter.date(from: "2013-04-07")!, season: seasonThree)
        seasonThree.add(episodes: s3e1, s3e2)
        
        let s4e1 = Episode(title: "Two Swords", releaseDate: dateFormatter.date(from: "2014-04-06")!, season: seasonFour, video: URL(string: "https://youtube.com/embed/Ih3WsEKmID0"))
        let s4e2 = Episode(title: "The Lion and the Rose", releaseDate: dateFormatter.date(from: "2014-04-013")!, season: seasonFour)
        seasonFour.add(episodes: s4e1, s4e2)
        
        let s5e1 = Episode(title: "The Wars to Come", releaseDate: dateFormatter.date(from: "2015-04-12")!, season: seasonFive, video: URL(string: "https://youtube.com/embed/yjQj4BCQSzo"))
        let s5e2 = Episode(title: "The House of Black and White", releaseDate: dateFormatter.date(from: "2015-04-19")!, season: seasonFive)
        seasonFive.add(episodes: s5e1, s5e2)
        
        let s6e1 = Episode(title: "The Red Woman", releaseDate: dateFormatter.date(from: "2016-04-24")!, season: seasonSix, video: URL(string: "https://youtube.com/embed/dKrhgVFTI6I"))
        let s6e2 = Episode(title: "Home", releaseDate: dateFormatter.date(from: "2016-05-01")!, season: seasonSix)
        seasonSix.add(episodes: s6e1, s6e2)
        
        let s7e1 = Episode(title: "Dragonstone", releaseDate: dateFormatter.date(from: "2017-06-16")!, season: seasonSeven, video: URL(string: "https://youtube.com/embed/giYeaKsXnsI"))
        let s7e2 = Episode(title: "Stormborn", releaseDate: dateFormatter.date(from: "2017-06-23")!, season: seasonSeven)
        seasonSeven.add(episodes: s7e1, s7e2)
        
        // Se relorna el listado ordenado por fecha de emisión
        return [seasonOne, seasonTwo, seasonThree, seasonFour, seasonSeven, seasonSix, seasonFive].sorted(by: { $0.releaseDate < $1.releaseDate })
    }
    
    func seasons(filteredBy: SeasonFilter) -> [Season] {
        return seasons.filter(filteredBy)
    }
    
}

