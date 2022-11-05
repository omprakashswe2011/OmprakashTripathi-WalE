//
//  MockFileCacheManager.swift
//  OmprakashTripathi-WalETests
//
//  Created by Om Prakash Tripathi on 05/11/22.
//
import XCTest
@testable import OmprakashTripathi_WalE

class MockFileCacheManager: FileCacheManagerProtocol {
    var mockIsFileExists = false
    var removeItemCalled = false
    var copyItemCalled = false
    var copyItemSourceURL: URL?
    var copyItemDestinationUrl: URL?
    var mockTemporaryDirectory: URL
    var temporaryDirectory: URL {
        mockTemporaryDirectory
    }

    init() {
        mockTemporaryDirectory =  URL(fileURLWithPath: "test")
    }

    func fileExists(atPath path: String) -> Bool {
        mockIsFileExists
    }

    func removeItem(at URL: URL) throws {
        removeItemCalled = true
    }

    func copyItem(at srcURL: URL, to dstURL: URL) throws {
        copyItemCalled = true
        copyItemSourceURL = srcURL
        copyItemDestinationUrl = dstURL
    }

}
