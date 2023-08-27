//
//  SportCellViewModel.swift
//  Sporty
//
//  Created by Smaro Goulianou on 26/8/23.
//

import Foundation
import UIKit


class SportCellViewModel {
    var events: [Event] = []

    weak var homescreenViewModelDelegate: HomescreenViewModel?


    init(events: [Event], homescreenViewModelDelegate: HomescreenViewModel?) {
        self.events = events
        self.homescreenViewModelDelegate = homescreenViewModelDelegate
        orderEvents()
    }


    /// Gets the number of the events.
    ///
    /// - Returns: The number of the events.
    func getEventsCount() -> Int {
        return events.count
    }


    /// Sets up the cell.
    ///
    /// - Parameters:
    ///   - cell: The cell to setup.
    ///   - sportName: The name of the sport.
    ///   - sportIconName: The name of the sport icon to display.
    ///   - isExpanded: If the cell is expanded or not.
    func setupSportsCell(cell: SportCellController, sportName: String, sportIconName: String, isExpanded: Bool) {
        cell.eventsCollectionView.isHidden = true
        cell.sportIconImageView.image = UIImage(named: sportIconName)
        cell.sportTitleLabel.text = sportName.capitalized
        toggleCell(isExpanded: isExpanded, imageView: cell.expandCollapseIconImageView, collectionView: cell.eventsCollectionView)
    }


    /// Expands or collapses the selected cell.
    ///
    /// - Parameters:
    ///   - isExpanded: If the sport cell is expanded.
    ///   - imageView: The expand/collapse image view to update its' icon
    ///   - collectionView: The events collection view to update.
    func toggleCell(isExpanded: Bool, imageView: UIImageView, collectionView: UICollectionView) {
        if isExpanded {
            expandCell(imageView: imageView, collectionView: collectionView)
        } else {
            collapseCell(imageView: imageView, collectionView: collectionView)
        }
    }


    /// Collapses the selected cell.
    ///
    /// - Parameters:
    ///   - imageView: The expand/collapse image view to update its' icon
    ///   - collectionView: The events collection view to hide it
    func collapseCell(imageView: UIImageView, collectionView: UICollectionView) {
        collectionView.isHidden = true
        imageView.image = UIImage(named: "expandIcon")
    }


    /// Expands the selected cell.
    ///
    /// - Parameters:
    ///   - imageView: The expand/collapse image view to update its' icon
    ///   - collectionView: The events collection view to display.
    func expandCell(imageView: UIImageView, collectionView: UICollectionView) {
        imageView.image = UIImage(named: "collapseIcon")
        collectionView.isHidden = false
        collectionView.reloadData()
    }


    /// Gets the event data of the desired index.
    ///
    /// - Parameter index: The index to get the event data.
    /// - Returns: The event data.
    func getEventData(index: Int) -> Event {
        return events[index]
    }


    /// Updates the events data.
    ///
    /// - Parameters:
    ///   - eventID: The id of the event to update.
    ///   - isFavourite: The favourite status of the event.
    func updateEventData(eventID: String, isFavourite: Bool) {
        guard let eventIndex = events.firstIndex(where: { $0.eventID == eventID }) else { return }
        events[eventIndex].isFavourite = isFavourite
        homescreenViewModelDelegate?.updateSportData(sportID: events[eventIndex].sportID, eventID: eventID, isFavourite: isFavourite)
    }


    /// Orders the events based on their favourite status.
    func orderEvents() {
        events = events.sorted(by: { (firstEvent, secondEvent) -> Bool in
            if firstEvent.isFavourite && !secondEvent.isFavourite {
                return true
            }

            if !firstEvent.isFavourite && secondEvent.isFavourite {
                return false
            }

            return false
        })
    }
}
