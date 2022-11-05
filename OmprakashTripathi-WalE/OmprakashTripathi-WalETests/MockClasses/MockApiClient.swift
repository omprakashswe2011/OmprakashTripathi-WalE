//
//  MockApiClient.swift
//  OmprakashTripathi-WalETests
//
//  Created by Om Prakash Tripathi on 05/11/22.
//

import XCTest
@testable import OmprakashTripathi_WalE

class MockApiClient: ApiClientProtocol, ImageDownloadable {
    var mockImageDatamodel:NasaImageOfTheDayModel?
    var mockdata:Data?

    func getDataFromAPI(with completion: @escaping (NasaImageOfTheDayModel?) -> ()) {
        completion(mockImageDatamodel)
    }
    
    func loadImageData(urlSting: String?, completion: @escaping (Data?, Error?) -> Void) {
        mockdata = Data()
        completion(mockdata, nil)
    }


}
