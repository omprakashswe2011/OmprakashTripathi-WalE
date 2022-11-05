//
//  FileCacheManager.swift
//  OmprakashTripathi-WalE
//
//  Created by Om Prakash Tripathi on 05/11/22.
//

import Foundation

public protocol FileCacheManagerProtocol {
    func fileExists(atPath path: String) -> Bool
    func removeItem(at URL: URL) throws
    func copyItem(at srcURL: URL, to dstURL: URL) throws
    var temporaryDirectory: URL { get }
}

extension FileManager: FileCacheManagerProtocol {}

