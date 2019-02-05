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

}
