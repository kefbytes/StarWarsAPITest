//
//  MockSession.swift
//  StarWarsAPITest
//
//  Created by Kent Franks on 2/5/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import Foundation

typealias DataTaskResponse = (Data?, URLResponse?, Error?)
typealias DataTaskCompletionHandler = (DataTaskResponse) -> Void

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping DataTaskCompletionHandler) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping DataTaskCompletionHandler) -> URLSessionDataTaskProtocol {
        return (dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask) as URLSessionDataTaskProtocol
    }
}

class MockURLSession: URLSessionProtocol {
    
    var mockSessionCalled = false
    var mockDataTask = MockURLSessionDataTask()
    var mockData: Data?
    var mockError: Error?
    
    func dataTask(with url: URL, completionHandler: @escaping DataTaskCompletionHandler) -> URLSessionDataTaskProtocol {
        mockSessionCalled = true
        completionHandler((mockData, nil, mockError))
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
