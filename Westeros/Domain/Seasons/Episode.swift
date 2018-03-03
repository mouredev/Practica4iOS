//
//  Episode.swift
//  Westeros
//
//  Created by Brais Moure on 3/3/18.
//  Copyright © 2018 Brais Moure. All rights reserved.
//

import UIKit

// MARK: - Episode
final class Episode {
    
    let title: String
    let releaseDate: Date
    weak var season: Season?
    let video: URL?
    
    init(title: String, releaseDate: Date, season: Season, video: URL? = nil) {
        self.title = title
        self.releaseDate = releaseDate
        self.season = season
        self.video = video
    }

}

// MARK: - Proxies
extension Episode {
    
    var proxyForEquality: String {
        return "\(title) \(releaseDate)"
    }
    
    var proxyForComparison: String {
        return description
    }
    
}

// MARK: - CustomStringConvertible
extension Episode: CustomStringConvertible {
    
    var description: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        let episodeDate = dateFormatter.string(from: releaseDate)
        return "Episode title: \(title), Episode release date: \(episodeDate), \(season?.description ?? String())"
    }
    
}

// MARK: - Equatable
extension Episode: Equatable {
    
    static func ==(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
    
}

// MARK: - Hashable
extension Episode: Hashable {
    
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
    
}

// MARK: - Comparable
extension Episode: Comparable {
    
    static func <(lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
    
}
