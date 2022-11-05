//
//  AstronomyPicHomeView.swift
//  OmprakashTripathi-WalE
//
//  Created by Om Prakash Tripathi on 04/11/22.
//

import Foundation
import SwiftUI

struct AstronomyPicHomeView: View {
    let vstakSpacing = 20.0
    @ObservedObject var viewModel: AstronomyPicHomeViewModel
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            Color.clear.onAppear(perform: viewModel.load)
        case .loading:
            ProgressView()
        case .failed(let error):
            Text(error)
        case .loaded(let dataModel):
            buildContent(dataModel)
            .alert(isPresented: $viewModel.showErrorAlert, content: {
                Alert(
                    title: Text(viewModel.errorAlertTitle),
                    message: Text(viewModel.errorAlertMessage),
                    dismissButton: .cancel(Text(viewModel.erroAlertOkTitle))
                )
            })
        }
    }

    init(viewModel: AstronomyPicHomeViewModel = AstronomyPicHomeViewModel()) {
        self.viewModel = viewModel
    }

    @ViewBuilder func buildContent(_ dataModel: NasaImageOfTheDayModel) -> some View {
        ScrollView {
            VStack(spacing: vstakSpacing) {
                Text(viewModel.title)
                HStack {
                    Text(dataModel.date)
                    Spacer()
                    Text(dataModel.title)
                }
                ImageView(withURL: dataModel.url)
                Text(dataModel.explanation)
            }
            .padding()
        }
    }
}
