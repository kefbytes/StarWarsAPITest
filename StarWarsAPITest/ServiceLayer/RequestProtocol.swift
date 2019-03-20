//
//  RequestProtocol.swift
//  
//
//  Created by Kent Franks on 2/12/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import Foundation

protocol RequestProtocol {
    
    var requestTypeMethod: HTTPMethod { get }
    var urlPath: String { get }
    var mockFileName: String { get }
    var urlArguments: [URLQueryItem]? { get }
    var headerItems: [String: String]? { get }
    var requestBody: Data? { get }
    var responseType: ResponseProtocol.Type { get }
    var taskId: String { get }
    
}

extension RequestProtocol {
    var taskId: String {
        get {
            return "dataTaskId.\(urlPath)"
        }
    }
}
