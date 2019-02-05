//
//  CharacterListVM.swift
//  StarWarsAPITest
//
//  Created by Kent Franks on 2/4/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import Foundation

class CharacterListVM {
    
    let serviceManager = ServiceManager()
    var starWarsCharacterArray = [StarWarsCharacter]()
    
    func fetchStarWarsCharacters(completion: @escaping () -> Void) {
        serviceManager.fetchStarWarsCharactersFromAPI() {
            (returnedCharactersArray) in
            guard let charactersArray = returnedCharactersArray else {
                completion()
                return
            }
            self.starWarsCharacterArray = charactersArray
            completion()
        }
    }
    
}
