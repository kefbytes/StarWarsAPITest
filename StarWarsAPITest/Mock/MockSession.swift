//
//  MockSession.swift
//  StarWarsAPITest
//
//  Created by Kent Franks on 2/5/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import Foundation

// These can't be used yet becasue they cause our extension to complaint that is doesn't conform to URLSessionProtocol
typealias DataTaskResponse = (Data?, URLResponse?, Error?)
typealias dataTaskCompletionHandler = (DataTaskResponse) -> Void

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return (dataTask(with: url))
    }
}

class MockURLSession: URLSessionProtocol {
    var mockSessionCalled = false
    var mockDataTask = MockURLSessionDataTask()
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        mockSessionCalled = true
        return mockDataTask
    }
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {
    
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    var mockResumeCalled = false
    func resume() {
        mockResumeCalled = true
    }
}
