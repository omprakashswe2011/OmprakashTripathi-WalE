//
//  AstronomyPicHomeModel.swift
//  OmprakashTripathi-WalE
//
//  Created by Om Prakash Tripathi on 04/11/22.
//

import Foundation

class AstronomyPicHomeModel {
    let apiClient: ApiClientProtocol
    
    init(apiClient: ApiClientProtocol = ApiClient()) {
        self.apiClient = apiClient
    }

    func fetchPicureOfTheDay(_ completion: @escaping (NasaImageOfTheDayModel?) -> ()) {
        apiClient.getDataFromAPI { dataModel in
            completion(dataModel)
        }
    }

}
