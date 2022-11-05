//
//  MockSessionDownloadTask.swift
//  OmprakashTripathi-WalETests
//
//  Created by Om Prakash Tripathi on 05/11/22.
//

import XCTest

internal class MockSessionDownloadTask: URLSessionDownloadTask {
    private let session: MockUrlSession
    var responseData: Data?
    var mockError: Error?
    var mockResponse: URLResponse?

    override var response: URLResponse? {
        mockResponse
    }

    override var error: Error? {
        mockError
    }

    private var taskDelegate: URLSessionTaskDelegate? {
        session.delegate as? URLSessionTaskDelegate
    }

    private var downloadDelegate: URLSessionDownloadDelegate? {
        session.delegate as? URLSessionDownloadDelegate
    }

    override var originalRequest: URLRequest? {
        let request = URLRequest(url: URL(string: "file://documents/tempfile.png")!)
        return request
    }

    init(session: MockUrlSession) {
        self.session = session
    }

    override func resume() {
        
    }
}

