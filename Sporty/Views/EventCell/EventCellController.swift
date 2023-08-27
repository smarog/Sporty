//
//  EventCellController.swift
//  Sporty
//
//  Created by Smaro Goulianou on 26/8/23.
//

import UIKit

class EventCellController: UICollectionViewCell {
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var countDownView: UIView!
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var firstCompetiroLabel: UILabel!
    @IBOutlet weak var secondCompetitorLabel: UILabel!

    var eventCellViewModel: EventCellViewModel?
    var countDownTimer: Timer?


    deinit {
        countDownTimer?.invalidate()
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    /// Sets up the event cell.
    ///
    /// - Parameters:
    ///   - eventData: The event data to set.
    ///   - sportViewModelDelegate: The sports view model delegate.
    func setupCell(eventData: Event, sportViewModelDelegate: SportCellViewModel?) {
        eventCellViewModel = EventCellViewModel(event: eventData, sportViewModelDelegate: sportViewModelDelegate)
        eventCellViewModel?.setEventCell(cell: self)
        countDownTimer = Timer.scheduledTimer(timeInterval: 1.0,
                                              target: self,
                                              selector: #selector(updateCountDownTimerLabel),
                                              userInfo: nil,
                                              repeats: true)
    }


    /// Updates the count down timer label.
    @objc func updateCountDownTimerLabel() {
        eventCellViewModel?.updateCountDownTimerLabel(label: countDownLabel, timer: countDownTimer)
    }


    /// Toggles the events favourite status.
    ///
    /// - Parameter sender: The favourite button that was pressed.
    @IBAction func toggleFavourite(_ sender: UIButton) {
        eventCellViewModel?.toggleFavouriteEvent(button: sender)
    }
}
