//
//  CharacterListVM.swift
//  StarWarsAPITest
//
//  Created by Kent Franks on 2/4/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import Foundation

class CharacterListVM {
    
    var starWarsCharacterArray = [StarWarsCharacter]()
    var request = FetchCharactersRequest()
    let prodConfig = ProdConfig()

    func fetchStarWarsCharacters(completion: @escaping () -> Void) {
        let serverConnection = KefBytesServerConnection(config: prodConfig)
        serverConnection.execute(with: request) {
            (response, error) in
            if let _ = error {
                // present alert
                return
            }
            guard let fetchCharactersResponse = response as? FetchCharactersResponse else {
                // present alert
                return
            }
            self.starWarsCharacterArray = fetchCharactersResponse.characters
            self.fetchNextPageOfCharacters() {
                () in
                completion()
            }
        }
    }
    
    func fetchNextPageOfCharacters(completion: @escaping () -> Void) {
        let serverConnection = KefBytesServerConnection(config: prodConfig)
        let queryItem = URLQueryItem(name: "page", value: "2")
//        let queryItem2 = URLQueryItem(name: "page", value: "3")
//        let queryItem3 = URLQueryItem(name: "page", value: "4")
//        request.urlArguments = [queryItem, queryItem2, queryItem3]
        request.urlArguments = [queryItem]
        serverConnection.execute(with: request) {
            (response, error) in
            if let _ = error {
                // present alert
                return
            }
            guard let fetchCharactersResponse = response as? FetchCharactersResponse else {
                // present alert
                return
            }
            self.starWarsCharacterArray.append(contentsOf: fetchCharactersResponse.characters)
            completion()
        }
    }
    
}
