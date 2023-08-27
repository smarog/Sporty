//
//  HomescreenViewModel.swift
//  Sporty
//
//  Created by Smaro Goulianou on 26/8/23.
//

import Foundation
import UIKit

enum SportID: String {
    case football = "FOOT"
    case basketball = "BASK"
    case tennis = "TENN"
    case tableTennis = "TABL"
    case esports = "ESPS"
    case baseball = "BASE"
    case handball = "HAND"
    case beachVolley = "BCHV"
    case darts = "DART"
}


class HomescreenViewModel {
    static var sharedInstance = HomescreenViewModel()

    var sportsData: [Sports] = []


    /// Retrieves the sport events from the API.
    ///
    /// - Parameters:
    ///   - successCallback: The action to be done when the API completes successfully.
    ///   - errorCallBack: The action to be done if we receive an error from the API.
    func loadSportEvents(successCallback: @escaping () -> Void, errorCallBack: @escaping () -> Void) {
        let serviceProvider = ServiceProvider.sharedInstance
        
        serviceProvider.load(service: SportyServices(), decodeType: [Sports].self, completion: { result in
            switch result {
            case .success(let responseData):
                self.sportsData = responseData
                successCallback()
            case .failure(let error):
                self.sportsData = []
                errorCallBack()
                print(error)
            }
        })
    }


    /// Gets the number of sport categories received from the API.
    ///
    /// - Returns: The number of sport categories.
    func getSportsCount() -> Int {
        return sportsData.count
    }


    /// Displays an alert dialog when we receive an error from the API.
    ///
    /// - Parameter alertAction: The action to be done when the user taps on the try again button.
    func errorCallback(alertAction: @escaping () -> Void) {
        let alertController = UIAlertController(title: "Error",
                                                message: "Oops, something went wrong. Please try again.",
                                                preferredStyle: .alert)
        let tryAgainAction = UIAlertAction(title: "Try again", style: .default, handler: { _ in
            alertAction()
        })

        alertController.addAction(tryAgainAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true)
    }


    /// Gets the sport id based on the selected index.
    ///
    /// - Parameter selectedIndex: The index of the cell to get its' sport id.
    /// - Returns: The sport id.
    func getSelectedSportID(selectedIndex: Int) -> SportID? {
        let sport = sportsData[selectedIndex]
        let sportID = sport.sportID
        let formattedSportID = SportID(rawValue: sportID)

        return formattedSportID
    }


    /// Sets up the sports cell.
    ///
    /// - Parameters:
    ///   - cell: The cell to set up.
    ///   - index: The index of the cell.
    /// - Returns: The created cell.
    func setupSportCell(cell: SportCellController, index: Int) -> SportCellController {
        let sport = sportsData[index]
        if let formattedSportID = getSelectedSportID(selectedIndex: index) {
            let sportIconName = getSportIconName(formattedSportID)
            let events = getSportEvents(sportID: formattedSportID)
            cell.setupCell(sportIconName: sportIconName,
                           sportName: sport.sportName,
                           isExpanded: sport.isExpanded,
                           sportEvents: events,
                           homescreenViewModelDelegate: self)
        }

        return cell
    }


    /// Gets the sport icon name based on the sport id.
    ///
    /// - Parameter sportID: The id of the sport to get its' icon name.
    /// - Returns: The icon name.
    func getSportIconName(_ sportID: SportID) -> String {
        switch sportID {
        case .football:
            return "sockerIcon"
        case .basketball:
            return "basketballIcon"
        case .tennis,
            .tableTennis:
            return "tennisIcon"
        case .esports:
            return "esportsIcon"
        case .baseball:
            return "baseballIcon"
        case .handball:
            return "handballIcon"
        case .beachVolley:
            return "volleyballIcon"
        case .darts:
            return "dartsIcon"
        }
    }


    /// Expands or collapses the sports cell.
    ///
    /// - Parameters:
    ///   - cell: The cell to expand or collapse.
    ///   - index: The index of the cell
    func expandCollapseCell(cell: SportCellController, index: Int) {
        guard let selectedSportID = getSelectedSportID(selectedIndex: index) else { return }
        toggleExpandedSport(sportID: selectedSportID)

        guard let selectedSport = sportsData.first(where: { $0.sportID == selectedSportID.rawValue }) else { return }
        cell.expandCollapseCell(isExpanded: selectedSport.isExpanded)
    }


    /// Changes the isExpanded value of the sport.
    ///
    /// - Parameter sportID: The id of the sport to edit.
    func toggleExpandedSport(sportID: SportID) {
        guard let index = sportsData.firstIndex(where: { $0.sportID == sportID.rawValue }) else { return }
        if sportsData[index].isExpanded {
            sportsData[index].isExpanded = false
        } else {
            sportsData[index].isExpanded = true
        }
    }


    /// Gets the events based on the sport id.
    ///
    /// - Parameter sportID: The sport id to get its' events.
    /// - Returns: Array containing the events.
    func getSportEvents(sportID: SportID) -> [Event] {
        guard let selectedSport = sportsData.first(where: { $0.sportID == sportID.rawValue }) else { return [] }

        return selectedSport.events
    }


    /// Updates the sport events datada.
    ///
    /// - Parameters:
    ///   - sportID: The id of the sport to update its event data.
    ///   - eventID: The id of the event to update.
    ///   - isFavourite: The favourite status of the event.
    func updateSportData(sportID: String, eventID: String, isFavourite: Bool) {
        guard let sportIndex = sportsData.firstIndex(where: { $0.sportID == sportID }) else { return }
        guard let eventIndex =  sportsData[sportIndex].events.firstIndex(where: { $0.eventID == eventID }) else { return }

        sportsData[sportIndex].events[eventIndex].isFavourite = isFavourite
    }
}
