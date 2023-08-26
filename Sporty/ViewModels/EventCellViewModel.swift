//
//  EventCellViewModel.swift
//  Sporty
//
//  Created by Smaro Goulianou on 26/8/23.
//

import Foundation
import UIKit

class EventCellViewModel {
    var event: Event = Event(eventID: "", sportID: "", eventName: "", startTime: 0)


    init(event: Event) {
        self.event = event
    }


    /// Sets up the event cell.
    ///
    /// - Parameter cell: The cell to setup.
    func setEventCell(cell: EventCellController) {
        let competitorsNames = getCompetitorsNames()

        cell.firstCompetiroLabel.text = competitorsNames["firstCompetitor"]
        cell.secondCompetitorLabel.text = competitorsNames["secondCompetitor"]
        setCountDownViewBorder(view: cell.countDownView)
        cell.countDownLabel.text = String(event.startTime)
    }


    /// Gets the competitors names from the event name.
    ///
    /// - Returns: Dictionary containing the competitors names.
    func getCompetitorsNames() -> [String: String] {
        let eventName = event.eventName
        let competitors = eventName.split(separator: "-")

        let competitorsNames: [String: String] = [
            "firstCompetitor": String(competitors[0]),
            "secondCompetitor": String(competitors[1])
        ]

        return competitorsNames
    }


    /// Sets the border of the count down view.
    ///
    /// - Parameter view: The view to set the borders at.
    func setCountDownViewBorder(view: UIView) {
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "cream")?.cgColor
    }
}
