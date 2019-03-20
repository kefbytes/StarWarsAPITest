//
//  FetchFilmsResponse.swift
//  StarWarsAPITest
//
//  Created by Kent Franks on 2/15/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import Foundation

//struct FetchFilmsResponse: ResponseProtocol {
//    
//    var urlResponse: URLResponse?
//    let films: [StarWarsFilm]
//    
//    init(data: Data?, urlResponse: URLResponse?) throws {
//        if let jsonData = data {
//            let response = try JSONDecoder().decode(StarWarsFilmsFetchResponse.self, from: jsonData)
//            self.urlResponse = urlResponse
//            guard let filmsArray = response.results else {
//                self.films = [StarWarsFilm]()
//                return
//            }
//            self.films = filmsArray
//        } else {
//            self.urlResponse = URLResponse()
//            self.films = [StarWarsFilm]()
//        }
//    }
//    
//}
