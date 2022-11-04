//
//  ImageViewModel.swift
//  OmprakashTripathi-WalE
//
//  Created by Om Prakash Tripathi on 04/11/22.
//

import Foundation
import Combine

class ImageViewModel: ObservableObject {
    var urlString: String?
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    var imageModel: ImageModel

    init(urlString: String?, imageModel: ImageModel = ImageModel()) {
        self.imageModel = imageModel
        self.urlString = urlString
    }
    func loadImageData() {
        imageModel.loadImageData(urlSting: urlString) { data, error in
            if data != nil {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.data = data
                }
            }
        }
    }
}
