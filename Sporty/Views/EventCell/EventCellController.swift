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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    /// Sets up the event cell.
    ///
    /// - Parameter eventData: The event data to set.
    func setupCell(eventData: Event) {
        eventCellViewModel = EventCellViewModel(event: eventData)
        eventCellViewModel?.setEventCell(cell: self)
    }


    @IBAction func toggleFavourite(_ sender: UIButton) {
    }
}
