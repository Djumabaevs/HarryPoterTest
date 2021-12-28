//
//  Episode.swift
//  HarryPoterTest
//
//  Created by Bakyt Dzhumabaev on 28/12/21.
//

import Foundation

struct PagedEpisode: Codable {
    let info: Info
    let results: [Episode]
}

struct Episode: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    
}
