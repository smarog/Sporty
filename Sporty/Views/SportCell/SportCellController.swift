//
//  SportCellController.swift
//  Sporty
//
//  Created by Smaro Goulianou on 26/8/23.
//

import UIKit

class SportCellController: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var sportIconImageView: UIImageView!
    @IBOutlet weak var sportTitleLabel: UILabel!
    @IBOutlet weak var expandCollapseIconImageView: UIImageView!
    @IBOutlet weak var eventsCollectionView: UICollectionView!

    var sportCellViewModel: SportCellViewModel?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        eventsCollectionView.delegate = self
        eventsCollectionView.dataSource = self
        eventsCollectionView.register(UINib(nibName: "EventCellController", bundle: nil), forCellWithReuseIdentifier: "eventCell")
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }


    /// Sets up the cell.
    ///
    /// - Parameters:
    ///   - sportIconName: The name of the sport icon.
    ///   - sportName: The name of the sport to display.
    ///   - isExpanded: If the cell is expanded or not.
    ///   - sportEvents: The events of the selected sport.
    func setupCell(sportIconName: String, sportName: String, isExpanded: Bool, sportEvents: [Event]) {
        sportCellViewModel = SportCellViewModel(events: sportEvents)
        sportCellViewModel?.setupSportsCell(cell: self, sportName: sportName, sportIconName: sportIconName, isExpanded: isExpanded)
    }


    /// Expands or collapses the selected cell.
    ///
    /// - Parameter isExpanded: If the cell is expanded or not.
    func expandCollapseCell(isExpanded: Bool) {
        sportCellViewModel?.toggleCell(isExpanded: isExpanded, imageView: expandCollapseIconImageView, collectionView: eventsCollectionView)
    }


    // MARK: - UICollectionView delegate methods

    /// Returns the number of the cells in each section.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportCellViewModel?.getEventsCount() ?? 0
    }


    /// Sets up the collection view cell.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventCellController
        guard let event = sportCellViewModel?.getEventData(index: indexPath.item) else { return cell }
        cell.setupCell(eventData: event)
        return cell
    }
}
