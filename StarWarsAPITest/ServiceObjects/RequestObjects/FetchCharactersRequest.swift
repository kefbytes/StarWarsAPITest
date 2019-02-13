//
//  FetchCharactersRequest.swift
//  StarWarsAPITest
//
//  Created by Kent Franks on 2/12/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import Foundation

struct FetchCharactersRequest: KefBytesRequestProtocol {
    
    var requestTypeMethod: HTTPMethod = .get
    var urlPath: String = "/people/"
    var urlArguments: [URLQueryItem]? = nil
    var headerItems: [String : String]? = nil
    var requestBody: Data? =  nil
    var responseType: KefBytesResponseProtocol.Type = FetchCharactersResponse.self
    
}
