//
//  ServiceManager.swift
//  UnitTestDataTaskWithURL
//
//  Created by Kent Franks on 2/4/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import Foundation

struct ServiceManager {
    
    var session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchStarWarsCharactersFromAPI(completion: @escaping (([StarWarsCharacter]?) -> Void)) {
        
        let urlString = "https://swapi.co/api/people/"
        guard let url = URL(string: urlString) else {
            return
        }
        session.dataTask(with: url) { (data, response, error) in
            guard let jsonData = data else {
                return
            }
            do {
                let response = try JSONDecoder().decode(StarWarsCharactersFetchResponse.self, from: jsonData)
                guard let characterArray = response.results else {
                    completion(nil)
                    return
                }
                completion(characterArray)
            } catch {
                
            }
        } .resume()
        
    }
    
}
