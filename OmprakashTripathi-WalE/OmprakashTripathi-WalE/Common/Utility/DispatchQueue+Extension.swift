//
//  DispatchQueue+Extension.swift
//  OmprakashTripathi-WalE
//
//  Created by Om Prakash Tripathi on 05/11/22.
//

import Foundation

protocol DispatchQueueType {
    func async(execute work: @escaping @convention(block) () -> Void)
}
extension DispatchQueue: DispatchQueueType {
    func async(execute work: @escaping @convention(block) () -> Void) {
        async(group: nil, qos: .unspecified, flags: [], execute: work)
    }
}
