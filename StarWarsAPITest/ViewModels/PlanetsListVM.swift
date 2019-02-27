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
    var request2 = FetchPlanetsRequest()
    var requests = [KefBytesRequestProtocol]()
    let serverConfig = ServerConfig()
    let serverConnection: KefBytesServerConnection?
    
    // MARK: - Initializers
    init() {
        serverConnection = KefBytesServerConnection(config: serverConfig)
        request2.urlPath = "/planets/?page=2"
        requests.append(request)
        requests.append(request2)
    }
    
    // MARK: - Fetch functions
    func fetchStarWarsPlanets(completion: @escaping () -> Void) {
        serverConnection?.execute(withTwoAsyncRequestsOfTheSameType: requests, and: .get) {
            (response, error) in
            if let _ = error {
                // present alert
                return
            }
            guard let fetchPlanetsResponse1 = response?[0] as? FetchPlanetsResponse else {
                // present alert
                return
            }
            guard let fetchPlanetsResponse2 = response?[1] as? FetchPlanetsResponse else {
                // present alert
                return
            }
            self.starWarsPlanetsArray = fetchPlanetsResponse1.planets
            self.starWarsPlanetsArray += fetchPlanetsResponse2.planets
            completion()
        }
    }
    
}
