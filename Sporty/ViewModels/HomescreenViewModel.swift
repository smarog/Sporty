//
//  HomescreenViewModel.swift
//  Sporty
//
//  Created by Smaro Goulianou on 26/8/23.
//

import Foundation

class HomescreenViewModel {
    static let sharedInstance = HomescreenViewModel()


    /// Retrieves the sport events from the API.
    func loadSportEvents() {
        let serviceProvider = ServiceProvider()
        
        serviceProvider.load(service: SportyServices(), decodeType: [Sports].self, completion: { result in
            switch result {
            case .success(let responseData):
                print(responseData)
            case .failure(let error):
                print(error)
            case .empty:
                print("No data received")
            }
        })
    }
}
