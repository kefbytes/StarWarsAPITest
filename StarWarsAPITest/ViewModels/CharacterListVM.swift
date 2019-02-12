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
    let request = FetchCharactersRequest()
    
    func fetchStarWarsCharacters(completion: @escaping () -> Void) {
        
        let serverConfig = ProdConfig()
        let serverConnection = KefBytesServerConnection(config: serverConfig)
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
            completion()
        }
    }
    
}
