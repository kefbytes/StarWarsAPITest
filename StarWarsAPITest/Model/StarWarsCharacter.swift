//
//  StarWarsCharacter.swift
//  UnitTestDataTaskWithURL
//
//  Created by Kent Franks on 2/4/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import Foundation

struct StarWarsCharacter: Decodable {
    
    let name: String?
    let height: String?
    let mass: String?
    let hair_color: String?
    let skin_color: String?
    let eye_color: String?
    let birth_year: String?
    let gender: String?
    let homeworld: String?
    let films: [String]?
    let species: [String]?
    let vehicles: [String]?
    let created: String?
    let edited: String?
    let url: String?
    
}

struct StarWarsCharactersFetchResponse: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [StarWarsCharacter]?
}
