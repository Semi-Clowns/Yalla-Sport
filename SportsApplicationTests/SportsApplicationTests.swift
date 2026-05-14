//
//  SportsApplicationTests.swift
//  SportsApplicationTests
//
//  Created by Mahmoud  Raafat  on 04/05/2026.
//

import XCTest
import Alamofire
@testable import SportsApplication

class SportsApplicationTests: XCTestCase {

    var networkService: NetworkService!
    
    override func setUp() {
        super.setUp()
        networkService = NetworkService()
    }

    func test_fetchAllLeagues_returnsData() throws {
        let expectation = expectation(description: "API returns Leagues")
        
        networkService.getAllLeagues(sport: "football", responseType: LeagueResponse.self) { result in
            switch result {
                case .success(let response):
                    XCTAssertNotNil(response)
                print("Leagues count: \(response.result.count )")
                case .failure(let error):
                    XCTFail("Request failed: \(error.localizedDescription)")
                }
                expectation.fulfill()
        }
        
        waitForExpectations(timeout: 15)
    }
    
}
