//
//  MockDispatchQueue.swift
//  OmprakashTripathi-WalETests
//
//  Created by Om Prakash Tripathi on 05/11/22.
//

import Foundation
@testable import OmprakashTripathi_WalE

final class MockDispatchQueue: DispatchQueueType {
    func async(execute work: @escaping @convention(block) () -> Void) {
        work()
    }
}
