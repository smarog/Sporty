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
        updateCountDownTimerLabel(label: cell.countDownLabel, timer: cell.countDownTimer)
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


    /// Updates the event count down label.
    ///
    /// - Parameters:
    ///   - label: The label to update its' text.
    ///   - timer: The timer to invalidate if needed.
    func updateCountDownTimerLabel(label: UILabel, timer: Timer?) {
        guard let eventDate = convertEventStartTimeToDate() else {
            label.text = "-:-:-"
            timer?.invalidate()
            return
        }

        let currentDate = getCurentDate()
        let calendar = Calendar.current
        let difference = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: eventDate)

        if currentDate >= eventDate {
            timer?.invalidate()
            label.text = "STARTED"
        } else {
            label.text = getCountDownText(timeLeft: difference)
        }
    }


    /// Converts the event count down timestamp to date.
    ///
    /// - Returns: The date created.
    func convertEventStartTimeToDate() -> Date? {
        let startTime = event.startTime
        let eventDate = Date(timeIntervalSince1970: Double(startTime))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:SS"
        let stringDate = dateFormatter.string(from: eventDate)
        let formatedDate = dateFormatter.date(from: stringDate)
        return formatedDate
    }


    /// Gets the current date based on the user timezone.
    ///
    /// - Returns: The current date
    func getCurentDate() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: Date()))
        let currentDate = Date(timeInterval: seconds, since: Date())

        return currentDate
    }


    /// Creates the text to display at the count down label.
    ///
    /// - Parameter timeLeft: The date components containing the time left to the event.
    /// - Returns: The text that was created.
    func getCountDownText(timeLeft: DateComponents) -> String {
        let remainingDays = timeLeft.day ?? 0
        let remainingDaysText = remainingDays == 0 ? "" : "\(remainingDays)d "

        let remainingHours = timeLeft.hour ?? 0
        let remainingHoursText = remainingHours == 0 ? "00" : "\(remainingHours)"

        let remainingMinutes = timeLeft.minute ?? 0
        let remainingMinutesText = remainingMinutes == 0 ? "00" : "\(remainingMinutes)"

        let remainingSeconds = timeLeft.second ?? 0
        let remainingSecondsText = remainingSeconds == 0 ? "00" : "\(remainingSeconds)"


        return remainingDaysText + remainingHoursText + ":" + remainingMinutesText + ":" + remainingSecondsText
    }
}
