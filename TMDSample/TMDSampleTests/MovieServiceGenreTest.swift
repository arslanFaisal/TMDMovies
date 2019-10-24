//
//  MovieServiceGenreTest.swift
//  TMDSampleTests
//
//  Created by Arslan Faisal on 24/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import XCTest
@testable import TMDSample

class MovieServiceGenreTest: XCTestCase {

    let genreIdToFetch = 12
    var sut: TrendingMoviesService!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = TrendingMoviesService(NetworkHandler())
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let moviesGenrePromise = expectation(description: "Movies of genre id \(genreIdToFetch) fetched successfully.")
        sut.fetchTrendingMovies(page: 1, genre: genreIdToFetch) { [weak self] (data, error) in
            moviesGenrePromise.fulfill()
            XCTAssertNil(error, error ?? "Recieved some error")
            XCTAssertNotNil(data, "movies API response is nil")
            if let movies = data?.movies, !movies.isEmpty, let unWrappedSelf = self {
                XCTAssertTrue(unWrappedSelf.checkIfMovieGenreMatch(movies: movies), "Movies Recived does not match the genre set.")
            } else {
                XCTFail("Error: movies are nil")
            }
        }
        wait(for: [moviesGenrePromise], timeout: 3.0)
    }
    func checkIfMovieGenreMatch(movies: [Movie]) -> Bool {
        for movie in movies {
            if let foundGenre = movie.genreIds?.contains(genreIdToFetch){
                if !foundGenre {
                    return false
                }
            }
        }
        return true
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            
        }
    }

}
