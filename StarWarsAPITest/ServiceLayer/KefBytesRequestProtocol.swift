//
//  KefBytesRequestProtocol.swift
//  StarWarsAPITest
//
//  Created by Kent Franks on 2/12/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import Foundation

enum HTTPMethod {
    case get
    case post
    case put
}

protocol KefBytesRequestProtocol {
    
    var requestTypeMethod: HTTPMethod { get }
    var urlPath: String { get }
    var urlArguments: [URLQueryItem]? { get }
    var headerItems: [String: String]? { get }
    var requestBody: Data? { get }
    var responseType: KefBytesResponseProtocol.Type { get }
    
}
