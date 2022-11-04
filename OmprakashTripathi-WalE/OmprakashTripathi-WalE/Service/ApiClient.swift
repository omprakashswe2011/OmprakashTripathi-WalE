//
//  ApiClient.swift
//  OmprakashTripathi-WalE
//
//  Created by Om Prakash Tripathi on 04/11/22.
//

import Foundation
import UIKit
protocol ApiClientProtocol {
    func getDataFromAPI(with completion: @escaping (NasaImageOfTheDayModel?) -> ())
}

protocol ImageDownloadable {
    func loadImageData(urlSting: String?,
                       completion: @escaping (Data?, Error?) -> Void)
}

class ApiClient {
    let configManager: ConfigurationManager

    public var path: String? {
        "?api_key=\(self.configManager.apiKey())"
    }

    init(configManager: ConfigurationManager = ConfigurationManager.shared) {
        self.configManager = configManager
    }

    private func buildUrl() -> URL? {
        guard let baseUrl = configManager.baseUrl(),
              var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false) else {
                  print("Cannot build url for baseUrl")
                  return nil
              }
        components.queryItems = [
            URLQueryItem(name: "api_key", value: self.configManager.apiKey()),
        ]

        return components.url
    }

    private func parse(_ data: Data) throws -> NasaImageOfTheDayModel? {
        try JSONDecoder().decode(NasaImageOfTheDayModel.self, from: data)
    }

    private func download(url: URL, toFile file: URL, completion: @escaping (Error?) -> Void) {
        // Download the remote URL to a file
        let task = URLSession.shared.downloadTask(with: url) {
            (tempURL, response, error) in
            // Early exit on error
            guard let tempURL = tempURL else {
                completion(error)
                return
            }

            do {
                // Remove any existing document at file
                if FileManager.default.fileExists(atPath: file.path) {
                    try FileManager.default.removeItem(at: file)
                }

                // Copy the tempURL to file
                try FileManager.default.copyItem(
                    at: tempURL,
                    to: file
                )

                completion(nil)
            }

            catch _ {
                completion(error)
            }
        }
        task.resume()
    }

}

extension ApiClient: ApiClientProtocol, ImageDownloadable {
    func getDataFromAPI(with completion: @escaping (NasaImageOfTheDayModel?) -> ()) {
        let url = buildUrl()
        guard let unwrappedURL = url else {return}
        let session = URLSession.shared
        let task = session.dataTask(with: unwrappedURL) { (data, response, error) in
            print("Start")
            guard let unwrappedData = data else {return}
            do {
                let responseModel = try self.parse(unwrappedData)
                completion(responseModel)
            } catch {

                print(error)

            }

        }
        task.resume()

    }

    func loadImageData(urlSting: String?, completion: @escaping (Data?, Error?) -> Void) {
        guard let tempUrlString = urlSting, let url = URL(string: tempUrlString) else {
            return
        }
        let fileCachePath = FileManager.default.temporaryDirectory
            .appendingPathComponent(
                url.lastPathComponent,
                isDirectory: false
            )

        if let data = try? Data(contentsOf: URL(fileURLWithPath: fileCachePath.path),
                                options: .alwaysMapped) {
            completion(data, nil)
            return
        }

        download(url: url, toFile: fileCachePath) { (error) in
            let data = try? Data(contentsOf: URL(fileURLWithPath: fileCachePath.path),
                                 options: .alwaysMapped)
            completion(data, error)
        }
    }
}
