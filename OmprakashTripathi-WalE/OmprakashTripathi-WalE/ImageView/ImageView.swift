//
//  ImageView.swift
//  OmprakashTripathi-WalE
//
//  Created by Om Prakash Tripathi on 04/11/22.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject var imageViewModel: ImageViewModel
    @State var image:UIImage = UIImage()
    
    init(withURL urlString: String?) {
        imageViewModel = ImageViewModel(urlString: urlString)
    }
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onAppear(perform: imageViewModel.loadImageData)
            .onReceive(imageViewModel.didChange) { data in
                self.image = UIImage(data: data) ?? UIImage()
            }
        }
}
