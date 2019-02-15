//
//  FilmsListVM.swift
//  StarWarsAPITest
//
//  Created by Kent Franks on 2/15/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import Foundation

class FilmsListVM {
    
    // MARK: - Properties
    var starWarsFilmsArray = [StarWarsFilm]()
    var request = FetchFilmsRequest()
    let prodConfig = ProdConfig()
    let serverConnection: KefBytesServerConnection?
    let url: URL?
    
    // MARK: - Initializers
    init() {
        serverConnection = KefBytesServerConnection(config: prodConfig)
        guard let url = KefBytesURLHelper.buildURL(with: prodConfig, request: request) else {
            // present alert
            self.url = nil
            return
        }
        self.url = url
    }

    // MARK: - Fetch functions
    func fetchStarWarsFilms(completion: @escaping () -> Void) {
        serverConnection?.execute(with: request, and: .get) {
            (response, error) in
            if let _ = error {
                // present alert
                return
            }
            guard let fetchFilmsResponse = response as? FetchFilmsResponse else {
                // present alert
                return
            }
            self.starWarsFilmsArray = fetchFilmsResponse.films
            completion()
        }
    }

}
