//
//  UserDefaults+Extesion.swift
//  OmprakashTripathi-WalE
//
//  Created by Om Prakash Tripathi on 04/11/22.
//

import Foundation

protocol UserDefaultsManageCodableObject {
    func setCodableObject<T: Codable>(_ data: T?, forKey defaultName: String)
    func codableObject<T : Codable>(dataType: T.Type, key: String) -> T?
}

extension UserDefaults: UserDefaultsManageCodableObject {
    func setCodableObject<T: Codable>(_ data: T?, forKey defaultName: String) {
        let encoded = try? JSONEncoder().encode(data)
        set(encoded, forKey: defaultName)
    }

    func codableObject<T : Codable>(dataType: T.Type, key: String) -> T? {
        guard let userDefaultData = data(forKey: key) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: userDefaultData)
    }
}
