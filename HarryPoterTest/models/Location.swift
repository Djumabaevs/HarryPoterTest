//
//  Location.swift
//  HarryPoterTest
//
//  Created by Bakyt Dzhumabaev on 28/12/21.
//

import Foundation

struct PagedLocation: Codable {
    let info: Info
    let results: [Location]
}

struct Location: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
}
