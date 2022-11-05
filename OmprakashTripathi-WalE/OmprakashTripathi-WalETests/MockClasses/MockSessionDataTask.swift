//
//  MockSessionDataTask.swift
//  OmprakashTripathi-WalETests
//
//  Created by Om Prakash Tripathi on 05/11/22.
//

import Foundation

internal class MockSessionDataTask: URLSessionDataTask {
    private let session: MockUrlSession
    var responseData: Data?
    var mockError: Error?
    var mockResponse: URLResponse?
    var resumeCalled = true
    override var response: URLResponse? {
        mockResponse
    }
    override var error: Error? {
        mockError
    }

    private var taskDelegate: URLSessionTaskDelegate? {
        session.delegate as? URLSessionTaskDelegate
    }

    private var dataDelegate: URLSessionDataDelegate? {
        session.delegate as? URLSessionDataDelegate
    }

    init(session: MockUrlSession) {
        self.session = session
    }

    override func resume() {
        resumeCalled = true
    }
        
}
