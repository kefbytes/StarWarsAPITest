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
typealias executeGroupCompletionDifferentTypes = ([String : KefBytesResponseProtocol]?, Error?) -> Void

class KefBytesServerConnection {
    
    let defaultSession = URLSession(configuration: .default)
    let serverConfig: KefBytesServerConfig
    var activeDataTasks: [String: URLSessionDataTask] = [:]
    
    init(config: KefBytesServerConfig) {
        self.serverConfig = config
    }
    
    func execute(with url: URL, and request: KefBytesRequestProtocol, completion: @escaping (executeCompletion)) {
        var dataTask: URLSessionDataTask?
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
            dataTask = defaultSession.dataTask(with: url) {
                (data, responseFromDataTask, error) in
                do {
                    self.activeDataTasks[request.taskId] = nil
                    guard let unwrappedResponse = responseFromDataTask else {
                        completion(nil, error)
                        return
                    }
                    let response = try request.responseType.init(data: data, urlResponse: unwrappedResponse)
                    completion(response, nil)
                } catch {
                    completion(nil, KefBytesServiceError.unableToInitResponseObject)
                }
            }
            dataTask?.resume()
            activeDataTasks[request.taskId] = dataTask
        }
    }
    
    func execute(with request: KefBytesRequestProtocol, and type: HTTPMethod, completion: @escaping (executeCompletion)) {
        var dataTask: URLSessionDataTask?
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
            
            dataTask = defaultSession.dataTask(with: urlRequest) {
                (data, responseFromDataTask, error) in
                do {
                    self.activeDataTasks[request.taskId] = nil
                    guard let unwrappedResponse = responseFromDataTask else {
                        completion(nil, error)
                        return
                    }
                    let response = try request.responseType.init(data: data, urlResponse: unwrappedResponse)
                    completion(response, nil)
                } catch {
                    completion(nil, KefBytesServiceError.unableToInitResponseObject)
                }
            }
            dataTask?.resume()
            activeDataTasks[request.taskId] = dataTask
        }
    }
    
    func execute(withMultipleAsyncRequests requests: [KefBytesRequestProtocol], and type: HTTPMethod, completion: @escaping (executeGroupCompletionDifferentTypes)) {
        var dataTask: URLSessionDataTask?
        var responseDict: [String : KefBytesResponseProtocol] = [String : KefBytesResponseProtocol]()
        if serverConfig.discoMode {
            guard let jsonData = MockJsonReader.readJson(with: requests[0].mockFileName) else {
                completion(nil, KefBytesServiceError.unableToReadMockJson)
                return
            }
            do {
                let response = try requests[0].responseType.init(data: jsonData, urlResponse: nil)
                responseDict[requests[0].urlPath] = response
                completion(responseDict, nil)
            } catch {
                completion(nil, KefBytesServiceError.unableToInitResponseObject)
            }
        } else {
            let dispatchGroup = DispatchGroup()
            let unwrappedRequests = requests.compactMap { $0 }
            for request in unwrappedRequests {
                dispatchGroup.enter()
                guard let url = KefBytesURLHelper.buildURL(with: serverConfig, request: request) else {
                    completion(nil, KefBytesServiceError.unbuildableURL)
                    return
                }
                let urlRequest = KefBytesURLRequest.create(with: url, type: type)
                dataTask = defaultSession.dataTask(with: urlRequest) {
                    (data, responseFromDataTask, error) in
                    self.activeDataTasks[request.taskId] = nil
                    do {
                        guard let unwrappedResponse = responseFromDataTask else {
                            if let errorDesc = error?.localizedDescription,  errorDesc == "cancelled" {
                                dispatchGroup.leave()
                                return
                            }
                            completion(nil, error)
                            return
                        }
                        let response = try request.responseType.init(data: data, urlResponse: unwrappedResponse)
                        responseDict[request.urlPath] = response

                    } catch {
                        completion(nil, KefBytesServiceError.unableToInitResponseObject)
                        dispatchGroup.leave()
                    }
                    dispatchGroup.leave()
                }
                dataTask?.resume()
                activeDataTasks[request.taskId] = dataTask
            }
            dispatchGroup.notify(queue: .main) {
                completion(responseDict, nil)
            }
        }
    }
    
    func cancelTask(with request: KefBytesRequestProtocol) {
        let dataTask = self.activeDataTasks[request.taskId]
        dataTask?.cancel()
    }
 
}
