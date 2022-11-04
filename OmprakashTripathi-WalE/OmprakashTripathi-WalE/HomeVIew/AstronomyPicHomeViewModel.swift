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

    init(model: AstronomyPicHomeModel = AstronomyPicHomeModel(),
         userDefault: UserDefaults = .standard) {
        self.model = model
        self.userDefault = userDefault
    }

    private func loadFromRemote() {
        model.fetchPicureOfTheDay { [weak self] imageOfTheDay in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if let imageOfTheDay = imageOfTheDay {
                    self.userDefault.setCodableObject(imageOfTheDay,
                                                      forKey: Constants.currentPicStoreInfoKey)
                    self.state = .loaded(imageOfTheDay)
                } else {
                    self.state = .failed(self.error)
                }
            }
        }
    }
    
    private func loadfromCache() {
        if let retrievedCodableObject = userDefault.codableObject(dataType: NasaImageOfTheDayModel.self,
                                                                  key: Constants.currentPicStoreInfoKey) {
            updateState(retrievedCodableObject: retrievedCodableObject)
        } else {
            state = .failed(error)
        }
    }
    
    private func updateState(retrievedCodableObject: NasaImageOfTheDayModel) {
        DispatchQueue.main.async { [weak self] in
            if self?.isDataFetchedToday(dataSavedDate: retrievedCodableObject.date) == false {
                print("AstronomyPicHomeViewModel: loadfromCache but found old image")
                self?.showErrorAlert = true
            }
            self?.state = .loaded(retrievedCodableObject)
        }
    }
    
    func isDataFetchedToday(dataSavedDate : String) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let imageSaveDate = formatter.date(from: dataSavedDate) else { return true}
        let isToday = Calendar.current.isDateInToday(imageSaveDate)
        return isToday
    }
    
    func load() {
        state = .loading
        if NetworkMonitor.shared.isReachable {
            print("AstronomyPicHomeViewModel: loadFromRemote")
            loadFromRemote()
        } else {
            print("AstronomyPicHomeViewModel: loadfromCache")
            loadfromCache()
        }
    }
}
