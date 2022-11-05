//
//  AstronomyPicHomeViewModel.swift
//  OmprakashTripathi-WalE
//
//  Created by Om Prakash Tripathi on 04/11/22.
//

import Foundation

enum LoadingState {
    case idle
    case loading
    case failed(String)
    case loaded(NasaImageOfTheDayModel)
}

class AstronomyPicHomeViewModel: ObservableObject {
    @Published private(set) var state = LoadingState.idle
    @Published var showErrorAlert = false
    let erroAlertOkTitle = "Ok"
    let errorAlertTitle = "Error"
    let errorAlertMessage = "We are not connected to the internet, showing you the last image we have."
    private(set) var title = "NASA Pic of the Day"
    private(set) var error = "Something went wrong"
    
    let model: AstronomyPicHomeModel
    let userDefault: UserDefaults
    let mainQueue: DispatchQueue

    init(model: AstronomyPicHomeModel = AstronomyPicHomeModel(),
         userDefault: UserDefaults = .standard,
         mainQueue: DispatchQueue = .main) {
        self.model = model
        self.userDefault = userDefault
        self.mainQueue = mainQueue
    }

    private func loadFromRemote() {
        model.fetchPicureOfTheDay { [weak self] imageOfTheDay in
            guard let self = self else { return }
            if let imageOfTheDay = imageOfTheDay {
                self.userDefault.setCodableObject(imageOfTheDay,
                                                  forKey: Constants.currentPicStoreInfoKey)
                self.updateUI(updatedState: .loaded(imageOfTheDay))
            } else {
                self.updateUI(updatedState: .failed(self.error))
            }
        }
    }

    private func retrieveSavedData() -> NasaImageOfTheDayModel? {
        userDefault.codableObject(dataType: NasaImageOfTheDayModel.self,
                                  key: Constants.currentPicStoreInfoKey)
    }

    private func loadfromCache() {
        if let retrievedCodableObject = retrieveSavedData() {
            updateState(retrievedCodableObject: retrievedCodableObject)
        } else {
            state = .failed(error)
        }
    }

    private func updateUI(updatedState: LoadingState, displayError: Bool = false) {
        mainQueue.async { [weak self] in
            self?.showErrorAlert = displayError
            self?.state = updatedState
        }
    }

    private func loadfromCacheSameDayPic() {
        if let retrievedCodableObject = retrieveSavedData() {
            updateUI(updatedState: .loaded(retrievedCodableObject))
        } else {
            updateUI(updatedState: .failed(error))
        }
    }

    private func updateState(retrievedCodableObject: NasaImageOfTheDayModel) {
        if isDataFetchedToday(dataSavedDate: retrievedCodableObject.date) == false {
            updateUI(updatedState: .loaded(retrievedCodableObject), displayError: true)
        } else {
            updateUI(updatedState: .loaded(retrievedCodableObject))
        }
    }

    private func isDataFetchedToday(dataSavedDate : String) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let imageSaveDate = formatter.date(from: dataSavedDate) else { return true}
        let isToday = Calendar.current.isDateInToday(imageSaveDate)
        return isToday
    }

    func load() {
        state = .loading
        if NetworkMonitor.shared.isReachable {
            if let retrievedCodableObject = retrieveSavedData(),
                isDataFetchedToday(dataSavedDate: retrievedCodableObject.date) == true {
                loadfromCacheSameDayPic()
            } else {
                loadFromRemote()
            }
        } else {
            loadfromCache()
        }
    }
}
