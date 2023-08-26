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
    private var sportsData: [Sports] = []


    /// Sets up the Navigation Bar.
    ///
    /// - Parameters:
    ///   - navigationController: The Navigation Controller to change its' colour.
    ///   - navigationItem: The Navigation item to ad the app Logo at.
    func setupNavigationBar(navigationController: UINavigationController?, navigationItem: UINavigationItem) {
        setupNavigationBarImage(navigationItem)

        if let unwrapedNavigationController = navigationController {
            setupNavigationBarColor(unwrapedNavigationController)
        }
    }


    /// Sets the navigiation bar background colour.
    ///
    /// - Parameter navigationController: The navigation controller to change its' color.
    func setupNavigationBarColor(_ navigationController: UINavigationController) {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(named: "greenLight")
            navigationController.navigationBar.standardAppearance = appearance
            navigationController.navigationBar.scrollEdgeAppearance = appearance
        } else {
            navigationController.navigationBar.backgroundColor = UIColor(named: "greenDark")
        }
    }


    /// Set the app logo at the Navigation Bar.
    ///
    /// - Parameter navigationItem: The navigation item to add the logo at.
    func setupNavigationBarImage(_ navigationItem: UINavigationItem) {
        guard let logo = UIImage(named: "titleLogo") else { return }
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }


    /// Retrieves the sport events from the API.
    func loadSportEvents(successCallback: @escaping () -> Void, errorCallBack: @escaping () -> Void, noDataCallback: @escaping () -> Void) {
        let serviceProvider = ServiceProvider()
        
        serviceProvider.load(service: SportyServices(), decodeType: [Sports].self, completion: { result in
            switch result {
            case .success(let responseData):
                self.sportsData = responseData
                successCallback()
            case .failure(let error):
                self.sportsData = []
                errorCallBack()
                print(error)
            case .empty:
                self.sportsData = []
                noDataCallback()
            }
        })
    }


    /// Gets the number of sport categories received from the API.
    ///
    /// - Returns: The number of sport categories.
    func getSportsCount() -> Int {
        return sportsData.count
    }


    /// Reloads the table view when we receive the API response successfully.
    ///
    /// - Parameter tableView: The tableView to reload.
    func successCallback(tableView: UITableView) {
        DispatchQueue.main.async {
            tableView.reloadData()
        }
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
            cell.setupCell(sportIconName: sportIconName, sportName: sport.sportName, isExpanded: sport.isExpanded, sportEvents: events)
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


    func errorCallback() {

    }

    
    func emptyResponseCallback() {
        
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
}
