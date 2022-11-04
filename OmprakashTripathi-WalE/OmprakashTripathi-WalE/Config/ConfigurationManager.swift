//
//  ConfigurationManager.swift
//  OmprakashTripathi-WalE
//
//  Created by Om Prakash Tripathi on 04/11/22.
//

import Foundation
internal enum Constants {
    static let appRootConfiguration = "AppConfiguration"
    static let configFileName = "NasaAppConfiguration"
    static let baseUrl = "baseUrl"
    static let apiKey = "apiKey"
    static let currentPicStoreInfoKey = "currentPicStoreInfoKey"
}

public class ConfigurationManager {
    private var config: [String: Any] = [:]
    public static var shared = ConfigurationManager()

    private init(configFileName: String = Constants.configFileName) {
        retrieveConfiguration(fileName: configFileName)
    }

    func baseUrl() -> URL? {
        if let baseUrlString = config[Constants.baseUrl] as? String {
            return URL(string: baseUrlString)
        }
        return nil
    }

    func apiKey() -> String {
        if let apiKeySting = config[Constants.apiKey] as? String {
            return apiKeySting
        }
        return ""
    }

    func retrieveConfiguration(fileName: String){
        if let infoPlistPath = Bundle.main.url(forResource: fileName, withExtension: "plist") {
            do {
                let infoPlistData = try Data(contentsOf: infoPlistPath)
                if let dict = try PropertyListSerialization.propertyList(from: infoPlistData,
                                                                         options: [],
                                                                         format: nil) as? [String: Any] {
                    config = dict[Constants.appRootConfiguration] as? [String: Any] ??  [:]
                }
            } catch {
                print(error)
            }
        }
    }
}
