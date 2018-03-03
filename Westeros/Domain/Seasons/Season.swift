//
//  Season.swift
//  Westeros
//
//  Created by Brais Moure on 3/3/18.
//  Copyright © 2018 Brais Moure. All rights reserved.
//

import UIKit

typealias Episodes = Set<Episode>

// MARK: - Season
final class Season {
    
    let title: String
    let releaseDate: Date
    private var _episodes: Episodes
    
    init(title: String, releaseDate: Date) {
        self.title = title
        self.releaseDate = releaseDate
        _episodes = Episodes()
    }

}

extension Season {

    func add(episode: Episode) {
        guard episode.season == self else {
            return
        }
        _episodes.insert(episode)
    }
    
    func add(episodes: Episode...) {
        episodes.forEach{ add(episode: $0) }
    }
    
    var sortedEpisodes: [Episode] {
        return _episodes.sorted(by: { $0.releaseDate < $1.releaseDate })
    }

}

// MARK: - Proxies
extension Season {
    
    var proxyForEquality: String {
        return "\(title) \(releaseDate)"
    }
    
    var proxyForComparison: String {
        return description
    }
    
}

// MARK: - CustomStringConvertible
extension Season: CustomStringConvertible {
    
    var description: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        let seasonDate = dateFormatter.string(from: releaseDate)
        return "Season title: \(title), Season release date: \(seasonDate)" //, Number of episodes: \(_episodes.count)
    }
    
}

// MARK: - Equatable
extension Season: Equatable {
    
    static func ==(lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
    
}

// MARK: - Hashable
extension Season: Hashable {
    
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
    
}

// MARK: - Comparable
extension Season: Comparable {
    
    static func <(lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
    
}
