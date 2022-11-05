//
//  ConfigurationManagerTest.swift
//  OmprakashTripathi-WalETests
//
//  Created by Om Prakash Tripathi on 05/11/22.
//

import XCTest
@testable import OmprakashTripathi_WalE

class ConfigurationManagerTest: XCTestCase {

    private var sut: ConfigurationManager!

    override func setUp() {
        super.setUp()
        sut = ConfigurationManager()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testBaeUrl () {
        let baseUrl = sut.baseUrl()
        let expectedUrl = URL(string: "https://api.nasa.gov/planetary/apod")

        XCTAssertNotNil(baseUrl)
        XCTAssertEqual(baseUrl, expectedUrl)
    }

    func testBaeUrl_nil() {
        sut = ConfigurationManager(configFileName: "https://test")
        let baseUrl = sut.baseUrl()
        let expectedUrl = URL(string: "https://api.nasa.gov/planetary/apod")

        XCTAssertNil(baseUrl)
        XCTAssertNotEqual(baseUrl, expectedUrl)
    }

    func testApiKey() {
        let apiKey = sut.apiKey()

        XCTAssertNotNil(apiKey)
    }

    func testApiKey_isEmpty() {
        sut = ConfigurationManager(configFileName: "https://test")

        let apiKey = sut.apiKey()
        XCTAssertTrue(apiKey.isEmpty)
    }

}
