//
//  KefBytesSession.swift
//  StarWarsAPITest
//
//  Created by Kent Franks on 2/19/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import Foundation

enum Environment: String {
    case dev = "Dev"
    case qa = "QA"
    case uat = "UAT"
    case prod = "Prod"
}

struct KefBytesSession {
    static var discoMode = false
    static var environment: Environment = .dev
}
