//
//  ServerConfig.swift
//  
//
//  Created by Kent Franks on 2/12/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import Foundation

protocol ServerConfigProtocol {
    var hostBase: String { get }
    var discoMode: Bool { get }
}

struct ServerConfig: ServerConfigProtocol {
    
    var hostBase: String = "https://swapi.co/api"
    var discoMode: Bool =  false

    init() {
        discoMode = Session.discoMode
        switch Session.environment {
        case .dev:
            hostBase = "https://swapi.co/api"
        case .qa:
            hostBase = "https://swapi.co/api"
        case .uat:
            hostBase = "https://swapi.co/api"
        case .prod:
            hostBase = "https://swapi.co/api"
        }
    }
}

