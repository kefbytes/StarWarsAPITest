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
    
    // https://swapi.co/api/people/?page=2
    func execute(with request: KefBytesRequestProtocol, completion: @escaping ((KefBytesResponseProtocol?, Error?) -> Void)) {
        let baseUrl: String = serverConfig.hostBase
        let endpoint: String = request.urlPath
        var args: String = ""
        if let urlArg = request.urlArguments {
            args = "?\(urlArg[0].name)=\(urlArg[0].value!)"
        }
        let urlString = baseUrl + endpoint + args
        let url = URL(string: urlString)
        session.dataTask(with: url!) { (data, response, error) in
            do {
                let fetchCharactersResponse = try FetchCharactersResponse(data: data, urlResponse: response!)
                completion(fetchCharactersResponse, error)
            } catch {
                
            }
        } .resume()
        
    }
}
