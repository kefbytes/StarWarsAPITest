//
//  KefBytesServerConnection.swift
//  StarWarsAPITest
//
//  Created by Kent Franks on 2/12/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import Foundation

typealias executeCompletion = (KefBytesResponseProtocol?, Error?) -> Void

class KefBytesServerConnection {
    
    let serverConfig: KefBytesServerConfig
    
    init(config: KefBytesServerConfig) {
        self.serverConfig = config
    }
    
    func execute(with request: KefBytesRequestProtocol, completion: @escaping (executeCompletion)) {
        guard let url = KefBytesURLHelper.buildURL(with: serverConfig, request: request) else {
            completion(nil, KefBytesServiceError.unbuildableURL)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, responseFromDataTask, error) in
            do {
                guard let unwrappedResponse = responseFromDataTask else {
                    completion(nil, error)
                    return
                }
                let response = try request.responseType.init(data: data, urlResponse: unwrappedResponse)
                completion(response, nil)
            } catch {
                
            }
        } .resume()
    }
    
}
