//
//  KefBytesResponseProtocol.swift
//  StarWarsAPITest
//
//  Created by Kent Franks on 2/12/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import Foundation

protocol KefBytesResponseProtocol {

    var urlResponse: URLResponse { get }
    init(data: Data?, urlResponse: URLResponse) throws

}
