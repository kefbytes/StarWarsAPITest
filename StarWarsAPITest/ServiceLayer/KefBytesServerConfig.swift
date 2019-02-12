//
//  KefBytesServerConfig.swift
//  StarWarsAPITest
//
//  Created by Kent Franks on 2/12/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import Foundation

protocol KefBytesServerConfig {
    var hostBase: String { get }
}

struct ProdConfig: KefBytesServerConfig {
    var hostBase: String = "https://swapi.co/api"
}

struct TestConfig: KefBytesServerConfig {
    var hostBase: String = "https://swapi.co/api"
}
