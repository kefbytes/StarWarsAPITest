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
    var request3 = FetchPlanetsRequest()
    var requests = [KefBytesRequestProtocol]()
    let serverConfig = ServerConfig()
    let serverConnection: KefBytesServerConnection?
    
    // MARK: - Initializers
    init() {
        serverConnection = KefBytesServerConnection(config: serverConfig)
        request2.urlPath = "/planets/?page=2"
        request3.urlPath = "/planets/?page=3"
        requests.append(request)
        requests.append(request2)
        requests.append(request3)
    }
    
    // MARK: - Fetch functions
    func fetchStarWarsPlanets(completion: @escaping () -> Void) {
        serverConnection?.execute(withMultipleAsyncRequestsOfTheSameType: requests, and: .get) {
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
            guard let fetchPlanetsResponse3 = response?[2] as? FetchPlanetsResponse else {
                // present alert
                return
            }
            self.starWarsPlanetsArray = fetchPlanetsResponse1.planets
            self.starWarsPlanetsArray += fetchPlanetsResponse2.planets
            self.starWarsPlanetsArray += fetchPlanetsResponse3.planets
            // TODO: Handle the force unwrap
            self.starWarsPlanetsArray = self.starWarsPlanetsArray.sorted { $0.name! < $1.name! }
            completion()
        }
    }
    
}
