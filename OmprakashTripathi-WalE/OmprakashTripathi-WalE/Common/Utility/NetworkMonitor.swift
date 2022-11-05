//
//  NetworkMonitor.swift
//  OmprakashTripathi-WalE
//
//  Created by Om Prakash Tripathi on 04/11/22.
//

import Network
protocol NetworkMonitorable  {
    var isReachable: Bool { get }
    func startMonitoring()
    func stopMonitoring()
}
class NetworkMonitor: NetworkMonitorable {
    static let shared = NetworkMonitor()

    let monitor = NWPathMonitor()
    private var status: NWPath.Status = .requiresConnection
    open var isReachable: Bool { status == .satisfied }

    open func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
        }

        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
    private init() {}
}
