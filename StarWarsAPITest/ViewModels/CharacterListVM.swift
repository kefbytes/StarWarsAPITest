//
//  CharacterListVM.swift
//  StarWarsAPITest
//
//  Created by Kent Franks on 2/4/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import Foundation

class CharacterListVM {
    
    // MARK: - Properties
    var starWarsCharacterArray = [StarWarsCharacter]()
//    var request = FetchCharactersRequest()
//    let serverConfig = ServerConfig()
//    let serverConnection: ServerConnection?
//    let url: URL?
    
    // MARK: - Initializers
//    init() {
//        serverConnection = ServerConnection(config: serverConfig)
//        guard let url = URLHelper.buildURL(with: serverConfig, request: request) else {
//            // present alert
//            self.url = nil
//            return
//        }
//        self.url = url
//    }

    // MARK: - Fetch functions
//    func fetchStarWarsCharacters(completion: @escaping () -> Void) {
//        guard let url = url else {
//            // present alert
//            return
//        }
//        serverConnection?.execute(with: url, and: request) {
//            (response, error) in
//            if let _ = error {
//                // present alert
//                return
//            }
//            guard let fetchCharactersResponse = response as? FetchCharactersResponse else {
//                // present alert
//                return
//            }
//            self.starWarsCharacterArray = fetchCharactersResponse.characters
//            self.fetchNextPageOfCharacters() {
//                () in
//                completion()
//            }
//        }
//    }
    
//    func fetchNextPageOfCharacters(completion: @escaping () -> Void) {
//        let queryItem = URLQueryItem(name: "page", value: "2")
//        request.urlArguments = [queryItem]
//        guard let url = URLHelper.buildURL(with: serverConfig, request: request) else {
//            // present alert
//            return
//        }
//        serverConnection?.execute(with: url, and: request) {
//            (response, error) in
//            if let _ = error {
//                // present alert
//                return
//            }
//            guard let fetchCharactersResponse = response as? FetchCharactersResponse else {
//                // present alert
//                return
//            }
//            self.starWarsCharacterArray.append(contentsOf: fetchCharactersResponse.characters)
//            completion()
//        }
//    }
    
}
