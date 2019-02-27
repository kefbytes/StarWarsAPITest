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
    
    func execute(with url: URL, and request: KefBytesRequestProtocol, completion: @escaping (executeCompletion)) {
        if serverConfig.discoMode {
            guard let jsonData = MockJsonReader.readJson(with: request.mockFileName) else {
                completion(nil, KefBytesServiceError.unableToReadMockJson)
                return
            }
            do {
                let response = try request.responseType.init(data: jsonData, urlResponse: nil)
                completion(response, nil)
            } catch {
                completion(nil, KefBytesServiceError.unableToInitResponseObject)
            }
        } else {
            URLSession.shared.dataTask(with: url) {
                (data, responseFromDataTask, error) in
                do {
                    guard let unwrappedResponse = responseFromDataTask else {
                        completion(nil, error)
                        return
                    }
                    let response = try request.responseType.init(data: data, urlResponse: unwrappedResponse)
                    completion(response, nil)
                } catch {
                    completion(nil, KefBytesServiceError.unableToInitResponseObject)
                }
            }.resume()
        }
    }
    
    func execute(with request: KefBytesRequestProtocol, and type: HTTPMethod, completion: @escaping (executeCompletion)) {
        if serverConfig.discoMode {
            guard let jsonData = MockJsonReader.readJson(with: request.mockFileName) else {
                completion(nil, KefBytesServiceError.unableToReadMockJson)
                return
            }
            do {
                let response = try request.responseType.init(data: jsonData, urlResponse: nil)
                completion(response, nil)
            } catch {
                completion(nil, KefBytesServiceError.unableToInitResponseObject)
            }
        } else {
            guard let url = KefBytesURLHelper.buildURL(with: serverConfig, request: request) else {
                completion(nil, KefBytesServiceError.unbuildableURL)
                return
            }
            let urlRequest = KefBytesURLRequest.create(with: url, type: type)
            
            URLSession.shared.dataTask(with: urlRequest) {
                (data, responseFromDataTask, error) in
                do {
                    guard let unwrappedResponse = responseFromDataTask else {
                        completion(nil, error)
                        return
                    }
                    let response = try request.responseType.init(data: data, urlResponse: unwrappedResponse)
                    completion(response, nil)
                } catch {
                    completion(nil, KefBytesServiceError.unableToInitResponseObject)
                }
            }.resume()
        }
    }
    
    func execute(with twoAsyncRequests: [KefBytesRequestProtocol], and type: HTTPMethod, completion: @escaping (executeCompletion)) {
        if serverConfig.discoMode {
            guard let jsonData = MockJsonReader.readJson(with: twoAsyncRequests[0].mockFileName) else {
                completion(nil, KefBytesServiceError.unableToReadMockJson)
                return
            }
            do {
                let response = try twoAsyncRequests[0].responseType.init(data: jsonData, urlResponse: nil)
                completion(response, nil)
            } catch {
                completion(nil, KefBytesServiceError.unableToInitResponseObject)
            }
        } else {
            var returningError: Error?
            var response: KefBytesResponseProtocol?
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            guard let url = KefBytesURLHelper.buildURL(with: serverConfig, request: twoAsyncRequests[0]) else {
                completion(nil, KefBytesServiceError.unbuildableURL)
                return
            }
            let urlRequest = KefBytesURLRequest.create(with: url, type: type)
            URLSession.shared.dataTask(with: urlRequest) {
                (data, responseFromDataTask, responseError) in
                do {
                    guard let unwrappedResponse = responseFromDataTask else {
                        returningError = responseError
                        return
                    }
                    response = try twoAsyncRequests[0].responseType.init(data: data, urlResponse: unwrappedResponse)
                } catch {
                    returningError = KefBytesServiceError.unableToInitResponseObject
                }
                dispatchGroup.leave()
            }.resume()
            completion(response, returningError)
        }
    }

}
