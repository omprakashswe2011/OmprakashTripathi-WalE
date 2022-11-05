# OmprakashTripathi-WalE

======================================
# Acceptance Criteria


1. Given: The NASA APOD API is up (working) AND the phone is connected to the internet When:
The user arrives at the APOD page for the first time today Then: The page should display the
image of Astronomy Picture of the Day along with the title and explanation, for that day

2. Given: The user has already seen the APOD page once AND the phone is not connected to
the internet When: The user arrives at the APOD page on the same day Then: The page
should display the image of Astronomy Picture of the Day along with the title and explanation,
for that day

3. Given: The user has not seen the APOD page today AND the phone is not connected to the
internet When: The user arrives at the APOD page Then: The page should display an error
"We are not connected to the internet, showing you the last image we have." AND The page
should display the image of Astronomy Picture of the Day along with the title and explanation,
that was last seen by the user

4. Given: The NASA APOD API is up (working) AND the phone is connected to the internet When:
The APOD image loads fully on the screen Then: The user should be able to see the complete
image without distortion or clipping

======================================
# Source Code of iOS OmprakashTripathi-WalE

  See https://github.com/omprakashswe2011/OmprakashTripathi-WalE for a detailed description 
  

======================================

# Implementation: 

 Followed the MVVM design pattern to implement this task

## 1. Implemented  ConfigurationManager class for fetching the config data base url and apiKey
    ConfigurationManager.shared.baseUrl() 
    ConfigurationManager.shared.apiKey() 

## 2. Implemented ApiClient to fetch the Astronomy Picture of the Day
        apiClient.loadImageData(urlSting: "url", completion: completion)
        apiClient.getDataFromAPI { dataModel in
                    completion(dataModel)
        }

## 3. Implemented NetworkMonitor for rechability check
       NetworkMonitor.shared.isReachable

## 4. Implemented UserDefaults+Extension for saving the Datamodel
        Saving : UserDefaults.standard.setCodableObject(imageOfTheDay, forKey: Constants.currentPicStoreInfoKey)
                    UserDefaults.standard.setCodableObject(imageOfTheDay,
                                                      forKey: Constants.currentPicStoreInfoKey)
        Retreving : UserDefaults.standard.codableObject(dataType: NasaImageOfTheDayModel.self,
                                                                  key: Constants.currentPicStoreInfoKey)

## 5. NasaImageOfTheDayModel is model for data mapping 

## 6. AstronomyPicHomeView is home view according to state its rendering the UI
    enum LoadingState {
        case idle // initial state
        case loading // when started fetching 
        case failed(String): // if something wrong to faile to load the image from repote for local
        case loaded(NasaImageOfTheDayModel): state one imgae loaded successfully from remote or cache
    }
    
    initialy State is idle so below code will execute

    this will show the white sreen and OnApppear  viewModel.load() get called the load the data from remote or cache
    Color.clear.onAppear(perform: viewModel.load) 
    
## 7 AstronomyPicHomeViewModel has all the businedd logic when to fetch the data from remote or cached according to Acceptance criteria 


# Finished work: 
 Implemented displaying  the Nasa the PIC of the day image and tried to meets the accepetence criteria 

# Unit test: 
Added unit test cases and approxmiate 90% code coverage cove in unit test cases

