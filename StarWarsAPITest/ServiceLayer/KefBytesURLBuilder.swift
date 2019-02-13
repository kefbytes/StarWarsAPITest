//
//  KefBytesURLHelper.swift
//  StarWarsAPITest
//
//  Created by Kent Franks on 2/13/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import Foundation

struct KefBytesURLHelper {
    
    static func buildURL(with config: KefBytesServerConfig, request: KefBytesRequestProtocol) -> URL? {
        let baseUrl: String = config.hostBase
        let endpoint: String = request.urlPath
        var args: String = ""
        if let urlArg = request.urlArguments {
            for (index, arg) in urlArg.enumerated() {
                switch index {
                case 0:
                    if let value = arg.value {
                        args += "?\(arg.name)=\(value)"
                    }
                default:
                    if let value = arg.value {
                        args += "&\(arg.name)=\(value)"
                    }
                }
            }
        }
        let urlString = baseUrl + endpoint + args
        return URL(string: urlString)
    }
    
}
