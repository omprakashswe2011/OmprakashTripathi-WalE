//
//  AstronomyPicHomeModelTest.swift
//  OmprakashTripathi-WalETests
//
//  Created by Om Prakash Tripathi on 05/11/22.
//

import XCTest
@testable import OmprakashTripathi_WalE

class AstronomyPicHomeModelTest: XCTestCase {

    private var sut: AstronomyPicHomeModel!
    private var mockApiClient: MockApiClient!

    override func setUp() {
        super.setUp()
        mockApiClient = MockApiClient()
        sut = AstronomyPicHomeModel(apiClient: mockApiClient)
    }

    override func tearDown() {
        mockApiClient = nil
        sut = nil
        super.tearDown()
    }
    
    func testFetchPicureOfTheDay() {
        let expectation = expectation(description: "fetchPicureOfTheDay")
        var responseModel: NasaImageOfTheDayModel?
        
        let mockImageDatamodel = NasaImageOfTheDayModel(date: "2022-11-05",
                                                        explanation: "test",
                                                        hdurl: "test/url.jpeg",
                                                        media_type: "test",
                                                        service_version: "1.0",
                                                        title: "Hello",
                                                        url: "temp/test.jpeg")
        mockApiClient.mockImageDatamodel = mockImageDatamodel

        sut.fetchPicureOfTheDay { model in
            responseModel = model
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10.0)
    
        XCTAssertNotNil(responseModel)

    }
    
}
