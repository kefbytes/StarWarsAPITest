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
    var session: URLSessionProtocol
    
    init(config: KefBytesServerConfig, session: URLSessionProtocol = URLSession.shared) {
        self.serverConfig = config
        self.session = session
    }
    
    func execute(with request: KefBytesRequestProtocol, completion: @escaping ((KefBytesResponseProtocol?, Error?) -> Void)) {
        let url = URL(string: "\(serverConfig.hostBase)\(request.urlPath)")
        session.dataTask(with: url!) { (data, response, error) in
            do {
                let fetchCharactersResponse = try FetchCharactersResponse(data: data, urlResponse: response!)
                completion(fetchCharactersResponse, error)
            } catch {
                
            }
        } .resume()
        
    }
}
