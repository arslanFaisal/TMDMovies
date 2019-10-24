//
//  GenreServiceTest.swift
//  TMDSampleTests
//
//  Created by Arslan Faisal on 24/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import XCTest
@testable import TMDSample
class GenreServiceTest: XCTestCase {

    var sut: GenreService!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = GenreService(NetworkHandler())
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let dataReceivedPromise = expectation(description: "Genres received Successfully")
        sut.fetchGenre(completion: { (genres, error) in
            dataReceivedPromise.fulfill()
            XCTAssertNil(error, error ?? "Recieved some error")
            XCTAssertNotNil(genres, "Genre List is nil")
            if let count = genres?.count {
                XCTAssertGreaterThan(count, 0, "Genre list is empty")
            }
        })
        wait(for: [dataReceivedPromise], timeout: 3.0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            testExample()
        }
    }

}
