//
//  StarWarsFilm.swift
//  StarWarsAPITest
//
//  Created by Kent Franks on 2/15/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import Foundation

struct StarWarsFilm: Decodable {
    
    let title: String?
    let episode_id: Int?
    let opening_crawl: String?
    let director: String?
    let producer: String?
    let release_date: String?
    let characters: [String]?
    let planets: [String]?
    let starships: [String]?
    let vehicles: [String]?
    let species: [String]?
    let created: String?
    let edited: String?
    let url: String?

}

struct StarWarsFilmsFetchResponse: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [StarWarsFilm]?
}
