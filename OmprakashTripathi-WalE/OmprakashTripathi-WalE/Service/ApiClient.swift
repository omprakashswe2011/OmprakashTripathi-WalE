//
//  ApiClient.swift
//  OmprakashTripathi-WalE
//
//  Created by Om Prakash Tripathi on 04/11/22.
//

import Foundation
import UIKit
protocol ApiClientProtocol {
    /// Fetch  Nasa pic of the day information from remote
    func getDataFromAPI(with completion: @escaping (NasaImageOfTheDayModel?) -> ())
}

protocol ImageDownloadable {
    /// LoadImageData remote  or Cache
    func loadImageData(urlSting: String?,
                       completion: @escaping (Data?, Error?) -> Void)
}

class ApiClient {
    let apiKey = "api_key"
    let configManager: ConfigurationManager
    let session: URLSession
    let fileManager: FileCacheManagerProtocol

    init(configManager: ConfigurationManager = ConfigurationManager(),
         session: URLSession = .shared,
         fileManager: FileCacheManagerProtocol = FileManager.default) {
        self.configManager = configManager
        self.session = session
        self.fileManager = fileManager
    }

    private func buildUrl() -> URL? {
        guard let baseUrl = configManager.baseUrl(),
              var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false) else {
                  print("Cannot build url for baseUrl")
                  return nil
              }
        components.queryItems = [
            URLQueryItem(name: apiKey, value: self.configManager.apiKey()),
        ]

        return components.url
    }

    private func parse(_ data: Data) throws -> NasaImageOfTheDayModel? {
        try JSONDecoder().decode(NasaImageOfTheDayModel.self, from: data)
    }
    
    
    private func manageFile(tempURL: URL,
                            file: URL,
                            error: Error?,
                            completion: @escaping (Error?) -> Void) {
        do {
            if self.fileManager.fileExists(atPath: file.path) {
                try self.fileManager.removeItem(at: file)
            }
            try self.fileManager.copyItem(
                at: tempURL,
                to: file
            )
            completion(nil)
        }
        catch _ {
            completion(error)
        }
    }

    private func download(url: URL, toFile file: URL, completion: @escaping (Error?) -> Void) {
        // Download the remote URL to a file
        let task = session.downloadTask(with: url) {
            [weak self] (tempURL, response, error) in
            // Early exit on error
            guard let self = self,
                    let tempURL = tempURL else {
                completion(error)
                return
            }

            self.manageFile(tempURL: tempURL,
                            file: file,
                            error: error,
                            completion: completion)
        }
        task.resume()
    }

}

extension ApiClient: ApiClientProtocol, ImageDownloadable {
    func getDataFromAPI(with completion: @escaping (NasaImageOfTheDayModel?) -> ()) {
        let url = buildUrl()
        guard let unwrappedURL = url else {return}
        //let session = URLSession.shared
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
        let fileCachePath = fileManager.temporaryDirectory
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
