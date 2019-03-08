//
//  FetchPlanetsRequest.swift
//  StarWarsAPITest
//
//  Created by Kent Franks on 2/20/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import Foundation

struct FetchPlanetsRequest: KefBytesRequestProtocol {
    
    var requestTypeMethod: HTTPMethod = .get
    var urlPath: String = "/planets/"
    var mockFileName: String = "FetchPlanets"
    var urlArguments: [URLQueryItem]? = nil
    var headerItems: [String : String]? = nil
    var requestBody: Data? =  nil
    var responseType: KefBytesResponseProtocol.Type = FetchPlanetsResponse.self

}
