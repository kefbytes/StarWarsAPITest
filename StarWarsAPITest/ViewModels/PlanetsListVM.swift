//
//  PlanetsListVM.swift
//  StarWarsAPITest
//
//  Created by Kent Franks on 2/20/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import Foundation

class PlanetsListVM {
    
    // MARK: - Properties
    var starWarsPlanetsArray = [StarWarsPlanet]()
    var request = FetchPlanetsRequest()
    let serverConfig = ServerConfig()
    let serverConnection: KefBytesServerConnection?
    
    // MARK: - Initializers
    init() {
        serverConnection = KefBytesServerConnection(config: serverConfig)
    }
    
    // MARK: - Fetch functions
    func fetchStarWarsPlanets(completion: @escaping () -> Void) {
        serverConnection?.execute(with: request, and: .get) {
            (response, error) in
            if let _ = error {
                // present alert
                return
            }
            guard let fetchPlanetsResponse = response as? FetchPlanetsResponse else {
                // present alert
                return
            }
            self.starWarsPlanetsArray = fetchPlanetsResponse.planets
            completion()
        }
    }
    
}
