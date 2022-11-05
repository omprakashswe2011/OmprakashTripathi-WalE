//
//  MockNetworkMonitor.swift
//  OmprakashTripathi-WalETests
//
//  Created by Om Prakash Tripathi on 05/11/22.
//

import XCTest
@testable import OmprakashTripathi_WalE

class MockNetworkMonitor: NetworkMonitorable {
    var startMonitoringCalled = false
    var stopMonitoringCalled = false
    var mockIsReachable = false
    var isReachable: Bool { mockIsReachable }

    func startMonitoring() {
        startMonitoringCalled = true
    }

    func stopMonitoring() {
        stopMonitoringCalled = true
    }
}
