//
//  ImageModel.swift
//  OmprakashTripathi-WalE
//
//  Created by Om Prakash Tripathi on 04/11/22.
//

import Foundation

class ImageModel {
    let apiClient: ImageDownloadable
    
    init(apiClient: ImageDownloadable = ApiClient()) {
        self.apiClient = apiClient
    }

    func loadImageData(urlSting: String?,
                       completion: @escaping (Data?, Error?) -> Void) {
        apiClient.loadImageData(urlSting: urlSting, completion: completion)
    }

}
