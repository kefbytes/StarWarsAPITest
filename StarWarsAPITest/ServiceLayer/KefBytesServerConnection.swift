//
//  KefBytesServerConnection.swift
//  StarWarsAPITest
//
//  Created by Kent Franks on 2/12/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import Foundation

class KefBytesServerConnection {
    
    let serverConfig: KefBytesServerConfig
    
    init(config: KefBytesServerConfig) {
        self.serverConfig = config
    }
    
    func execute(with request: KefBytesRequestProtocol, completion: @escaping ((KefBytesResponseProtocol?, Error?) -> Void)) {
        guard let url = KefBytesURLBuilder.buildURL(with: serverConfig, request: request) else {
            // display alert that url is not buildable
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let fetchCharactersResponse = try FetchCharactersResponse(data: data, urlResponse: response!)
                completion(fetchCharactersResponse, error)
            } catch {
                
            }
        } .resume()
    }
    
}
