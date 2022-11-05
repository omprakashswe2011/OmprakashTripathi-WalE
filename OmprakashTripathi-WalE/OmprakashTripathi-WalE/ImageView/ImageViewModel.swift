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
    let mainQueue: DispatchQueue

    init(urlString: String?,
         imageModel: ImageModel = ImageModel(),
         mainQueue: DispatchQueue = .main) {
        self.imageModel = imageModel
        self.urlString = urlString
        self.mainQueue = mainQueue
    }
    func loadImageData() {
        imageModel.loadImageData(urlSting: urlString) { [weak self] data, error in
            guard let self = self,
                  let data = data else { return }
            self.mainQueue.async {
                self.data = data
            }
        }
    }
}
