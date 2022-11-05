//
//  AstronomyPicHomeViewModelTest.swift
//  OmprakashTripathi-WalETests
//
//  Created by Om Prakash Tripathi on 05/11/22.
//

import XCTest
@testable import OmprakashTripathi_WalE

class AstronomyPicHomeViewModelTest: XCTestCase {

    private var sut: AstronomyPicHomeViewModel!
    private var mockApiClient: MockApiClient!
    private var mockUserDefault: MockUserDefaults!
    private var mockNetworkMonitor: MockNetworkMonitor!
    private var mockDispatchQueue: MockDispatchQueue!

    override func setUp() {
        super.setUp()
        mockUserDefault = MockUserDefaults()
        mockApiClient = MockApiClient()
        mockNetworkMonitor = MockNetworkMonitor()
        let model = AstronomyPicHomeModel(apiClient: mockApiClient)
        mockDispatchQueue = MockDispatchQueue()
        sut = AstronomyPicHomeViewModel(model: model,
                                        userDefault: mockUserDefault,
                                        mainQueue: mockDispatchQueue,
                                        networkMonitor: mockNetworkMonitor)
    }

    override func tearDown() {
        mockDispatchQueue = nil
        mockNetworkMonitor = nil
        mockUserDefault = nil
        mockApiClient = nil
        sut = nil
        super.tearDown()
    }
    
    func getMockImageDatamodel() -> NasaImageOfTheDayModel {
        NasaImageOfTheDayModel(date: "2022-11-05",
                               explanation: "test",
                               hdurl: "test/url.jpeg",
                               media_type: "test",
                               service_version: "1.0",
                               title: "Hello",
                               url: "temp/test.jpeg")
    }
    
    func testLoad_whenNetworkRechable() {
        mockNetworkMonitor.mockIsReachable = true
        mockUserDefault.mockCodableObject = nil
        let mockImageDatamodel = getMockImageDatamodel()
        mockApiClient.mockImageDatamodel = mockImageDatamodel
        sut.load()
        XCTAssertTrue(mockUserDefault.setCodableObjectCalled)
    }
    
    func testLoad_whenNetworkRechable_savedDataFound() {
        mockNetworkMonitor.mockIsReachable = true
        let mockImageDatamodel = getMockImageDatamodel()

        mockUserDefault.mockCodableObject = mockImageDatamodel
        mockApiClient.mockImageDatamodel = mockImageDatamodel
        sut.load()
        XCTAssertTrue(mockUserDefault.codableObjectCalled)
    }

    func testLoad_whenNetworkNotRechable() {
        mockNetworkMonitor.mockIsReachable = false
        mockUserDefault.mockCodableObject = nil
        let mockImageDatamodel = getMockImageDatamodel()

        mockApiClient.mockImageDatamodel = mockImageDatamodel
        sut.load()
        XCTAssertTrue(mockUserDefault.codableObjectCalled)
    }
    
    
    func testLoad_whenNetworkNotRechable_savedDataFound() {
        mockNetworkMonitor.mockIsReachable = false
        mockUserDefault.mockCodableObject = nil
        let mockImageDatamodel = getMockImageDatamodel()

        mockApiClient.mockImageDatamodel = mockImageDatamodel
        mockUserDefault.mockCodableObject = mockImageDatamodel
        sut.load()
        XCTAssertTrue(mockUserDefault.codableObjectCalled)
    }
}


