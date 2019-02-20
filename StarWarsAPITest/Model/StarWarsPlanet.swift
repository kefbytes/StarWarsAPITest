//
//  StarWarsPlanet.swift
//  StarWarsAPITest
//
//  Created by Kent Franks on 2/20/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import Foundation

struct StarWarsPlanet: Decodable {
    
    let name: String?
    let rotation_period: String?
    let orbital_period: String?
    let diameter: String?
    let climate: String?
    let gravity: String?
    let terrain: String?
    let planets: [String]?
    let surface_water: String?
    let population: String?
    let residents: [String]?
    let films: [String]?
    let created: String?
    let edited: String?
    let url: String?

}

struct StarWarsPlanetsFetchResponse: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [StarWarsPlanet]?
}
