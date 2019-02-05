//
//  StarWarsServiceManagerTests.swift
//  StarWarsAPITestTests
//
//  Created by Kent Franks on 2/5/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import XCTest
@testable import StarWarsAPITest

class StarWarsServiceManagerTests: XCTestCase {
    
    let session = MockURLSession()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testThatMockSessionIsCalled() {
        let serviceManager = ServiceManager(session: session)
        serviceManager.fetchStarWarsCharactersFromAPI() {
            (characterArray) in
        }
        XCTAssert(session.mockSessionCalled)
    }

    func testThatMockResumeIsCalled() {
        let serviceManager = ServiceManager(session: session)
        serviceManager.fetchStarWarsCharactersFromAPI() {
            (characterArray) in
        }
        XCTAssert(session.mockDataTask.mockResumeCalled)
    }
    
    func testDataComesBackFromFetchStarWarsCharactersFromAPI() {
        var responseArray: [StarWarsCharacter]?
        let serviceManager = ServiceManager(session: URLSession.shared)
        let testExpectation = expectation(description: "Wait for fetch to complete.")

        serviceManager.fetchStarWarsCharactersFromAPI() {
            (characterArray) in
            responseArray = characterArray
            testExpectation.fulfill()
        }

        wait(for: [testExpectation], timeout: 50)
        XCTAssertNotNil(responseArray)
    }
    
    func testFetchCharacters() {
        var responseArray: [StarWarsCharacter]?

        // Simply getting the file path to the local json file
        guard let filePath = Bundle.main.path(forResource: "FetchCharacters_FirstCall", ofType: "json") else {
            assert(false, "❌ Bad file path. FetchCharacters_FirstCall.json does not exist.")
        }
        
        // Read in the local json file
        guard let jsonData = FileManager.default.contents(atPath: filePath) else {
            assert(false, "❌ Unable to get contents of file")
        }

        session.mockData = jsonData
        let serviceManager = ServiceManager(session: session)

        serviceManager.fetchStarWarsCharactersFromAPI() {
            (characterArray) in
            responseArray = characterArray
        }
        
        XCTAssertNotNil(responseArray)
    }

}
