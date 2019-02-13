//
//  FetchCharactersResponse.swift
//  StarWarsAPITest
//
//  Created by Kent Franks on 2/12/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import Foundation

struct FetchCharactersResponse: KefBytesResponseProtocol {
    
    var urlResponse: URLResponse
    let characters: [StarWarsCharacter]
    
    init(data: Data?, urlResponse: URLResponse) throws {
        if let jsonData = data {
            let response = try JSONDecoder().decode(StarWarsCharactersFetchResponse.self, from: jsonData)
            self.urlResponse = urlResponse
            guard let characterArray = response.results else {
                self.characters = [StarWarsCharacter]()
                return
            }
            self.characters = characterArray
        } else {
            self.urlResponse = URLResponse()
            self.characters = [StarWarsCharacter]()
        }
    }
    
}
