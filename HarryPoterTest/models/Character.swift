//
//  Character.swift
//  HarryPoterTest
//
//  Created by Bakyt Dzhumabaev on 28/12/21.
//

import Foundation

struct PagedCharacter: Codable {
    let info: Info
    var results: [Character]
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: String?
    let species: String?
    let gender: String?
    let origin: CharLocation
    let location: CharLocation
    let episode: [String?]
    let image: String?
    let url: String?
    var imageData: Data?
}

struct CharLocation: Codable {
    let name: String
    let url: String
}
