//
//  MockUserDefaults.swift
//  OmprakashTripathi-WalETests
//
//  Created by Om Prakash Tripathi on 05/11/22.
//

import XCTest
@testable import OmprakashTripathi_WalE

class MockUserDefaults: UserDefaultsManageCodableObject {
    var setCodableObjectCalled = false
    var codableObjectCalled = false
    
    var mockCodableObject: NasaImageOfTheDayModel?

    func setCodableObject<T: Codable>(_ data: T?, forKey defaultName: String) {
        setCodableObjectCalled = true
    }

    func codableObject<T : Codable>(dataType: T.Type, key: String) -> T? {
        codableObjectCalled = true
        return mockCodableObject as? T
    }
}
