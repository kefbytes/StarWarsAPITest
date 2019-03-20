//
//  FetchPlanetsResponse.swift
//  StarWarsAPITest
//
//  Created by Kent Franks on 2/20/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import Foundation

struct FetchPlanetsResponse: ResponseProtocol {
    
    var urlResponse: URLResponse?
    let planets: [StarWarsPlanet]
    
    init(data: Data?, urlResponse: URLResponse?) throws {
        if let jsonData = data {
            let response = try JSONDecoder().decode(StarWarsPlanetsFetchResponse.self, from: jsonData)
            self.urlResponse = urlResponse
            guard let planetsArray = response.results else {
                self.planets = [StarWarsPlanet]()
                return
            }
            self.planets = planetsArray
        } else {
            self.urlResponse = URLResponse()
            self.planets = [StarWarsPlanet]()
        }
    }
    
}
