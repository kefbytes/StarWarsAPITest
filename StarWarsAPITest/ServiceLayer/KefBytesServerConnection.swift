//
//  KefBytesServerConnection.swift
//  StarWarsAPITest
//
//  Created by Kent Franks on 2/12/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import Foundation

typealias executeCompletion = (KefBytesResponseProtocol?, Error?) -> Void
typealias executeGroupCompletion = ([KefBytesResponseProtocol]?, Error?) -> Void

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
    
    func execute(withTwoAsyncRequestsOfTheSameType requests: [KefBytesRequestProtocol], and type: HTTPMethod, completion: @escaping (executeGroupCompletion)) {
        var responseArray: [KefBytesResponseProtocol] = [KefBytesResponseProtocol]()
        if serverConfig.discoMode {
            guard let jsonData = MockJsonReader.readJson(with: requests[0].mockFileName) else {
                completion(nil, KefBytesServiceError.unableToReadMockJson)
                return
            }
            do {
                let response = try requests[0].responseType.init(data: jsonData, urlResponse: nil)
                responseArray.append(response)
                completion(responseArray, nil)
            } catch {
                completion(nil, KefBytesServiceError.unableToInitResponseObject)
            }
        } else {
            let dispatchGroup = DispatchGroup()
            // First item in group
            dispatchGroup.enter()
            guard let url = KefBytesURLHelper.buildURL(with: serverConfig, request: requests[0]) else {
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
                    let response = try requests[0].responseType.init(data: data, urlResponse: unwrappedResponse)
                    responseArray.append(response)
                } catch {
                    completion(nil, KefBytesServiceError.unableToInitResponseObject)
                }
                dispatchGroup.leave()
            }.resume()
            
            // Second item in group
            dispatchGroup.enter()
            guard let url2 = KefBytesURLHelper.buildURL(with: serverConfig, request: requests[1]) else {
                completion(nil, KefBytesServiceError.unbuildableURL)
                return
            }
            let urlRequest2 = KefBytesURLRequest.create(with: url2, type: type)
            URLSession.shared.dataTask(with: urlRequest2) {
                (data, responseFromDataTask, error) in
                do {
                    guard let unwrappedResponse = responseFromDataTask else {
                        completion(nil, error)
                        return
                    }
                    let response = try requests[1].responseType.init(data: data, urlResponse: unwrappedResponse)
                    responseArray.append(response)
                } catch {
                    completion(nil, KefBytesServiceError.unableToInitResponseObject)
                }
                dispatchGroup.leave()
            }.resume()

            dispatchGroup.notify(queue: .main) {
                print("🤖 Both groups completed 👍")
                completion(responseArray, nil)
            }
        }
    }

}
