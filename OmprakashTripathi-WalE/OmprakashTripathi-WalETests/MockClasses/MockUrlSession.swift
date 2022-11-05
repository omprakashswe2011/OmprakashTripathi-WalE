//
//  MockUrlSession.swift
//  OmprakashTripathi-WalETests
//
//  Created by Om Prakash Tripathi on 05/11/22.
//

import Foundation


internal class MockUrlSession: URLSession {
    var responseData: Data?
    var response: URLResponse?
    var error: Error?
    var invalidateAndCancelCalled = 0
    private var url: URL?
    private var data: Data?
    private var statusCode: Int?
    
    private var _configuration: URLSessionConfiguration
    override var configuration: URLSessionConfiguration {
        _configuration
    }

    init(configuration: URLSessionConfiguration) {
        self._configuration = configuration
    }

    override func downloadTask(with url: URL,
                               completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask {
        let task = MockSessionDownloadTask(session: self)
        let mcokUrl = url
        task.responseData = responseData
        task.mockResponse = response
        task.mockError = error
        completionHandler(mcokUrl, response, error)
        return task

        
    }
    
    override open func dataTask(with url: URL,
                                completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = MockSessionDataTask(session: self)
        task.responseData = responseData
        task.mockResponse = response
        task.mockError = error
        completionHandler(responseData, response, error)
        return task
    }
}
