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
//    var request = FetchPlanetsRequest()
//    var request2 = FetchPlanetsRequest()
//    var request3 = FetchPlanetsRequest()
//    var requests = [RequestProtocol]()
//    let serverConfig = ServerConfig()
//    let serverConnection: ServerConnection?
    
    // MARK: - Initializers
//    init() {
//        serverConnection = ServerConnection(config: serverConfig)
//        request2.urlPath = "/planets/?page=2"
//        request3.urlPath = "/planets/?page=3"
//        requests.append(request)
//        requests.append(request2)
//        requests.append(request3)
//    }
    
    // MARK: - Fetch
//    func fetchStarWarsPlanets(completion: @escaping () -> Void) {
//        serverConnection?.execute(withMultipleAsyncRequests: requests, and: .get) {
//            (response, error) in
//            if let _ = error {
//                // present alert
//                return
//            }
//            if let fetchPlanetsResponse1 = response?[self.requests[0].urlPath] as? FetchPlanetsResponse {
//                self.starWarsPlanetsArray = fetchPlanetsResponse1.planets
//            }
//            if let fetchPlanetsResponse2 = response?[self.requests[1].urlPath] as? FetchPlanetsResponse {
//                self.starWarsPlanetsArray += fetchPlanetsResponse2.planets
//            }
//            if let fetchPlanetsResponse3 = response?[self.requests[2].urlPath] as? FetchPlanetsResponse {
//                self.starWarsPlanetsArray += fetchPlanetsResponse3.planets
//            }
//            self.starWarsPlanetsArray = self.starWarsPlanetsArray.sorted {
//                guard let name1 = $0.name, let name2 = $1.name else {
//                    return false
//                }
//                return name1 < name2
//            }
//            completion()
//        }
//    }

}
