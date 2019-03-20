//
//  FetchFilmsRequest.swift
//  StarWarsAPITest
//
//  Created by Kent Franks on 2/15/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import Foundation

struct FetchFilmsRequest: RequestProtocol {
    
    var requestTypeMethod: HTTPMethod = .get
    var urlPath: String = "/films/"
    var mockFileName: String = "FetchFilms"
    var urlArguments: [URLQueryItem]? = nil
    var headerItems: [String : String]? = nil
    var requestBody: Data? =  nil
    var responseType: ResponseProtocol.Type = FetchFilmsResponse.self

}
