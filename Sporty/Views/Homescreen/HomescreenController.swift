//
//  HomescreenController.swift
//  Sporty
//
//  Created by Smaro Goulianou on 25/8/23.
//

import UIKit

class HomescreenController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var sportsTableView: UITableView!
    
    let homescreenViewModel = HomescreenViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }


    /// Sets up the view.
    func setupView() {
        homescreenViewModel.setupNavigationBar(navigationController: self.navigationController, navigationItem: self.navigationItem)
        setupTableView()

        homescreenViewModel.loadSportEvents(successCallback: {
            self.homescreenViewModel.successCallback(tableView: self.sportsTableView)
        }, errorCallBack: {
            self.homescreenViewModel.errorCallback()
        }, noDataCallback: {
            self.homescreenViewModel.emptyResponseCallback()
        })
    }


    /// Registers the custom table view cell and sets the estimated row height.
    func setupTableView() {
        sportsTableView.register(UINib(nibName: "SportCellController", bundle: nil), forCellReuseIdentifier: "sportCell")
        sportsTableView.estimatedRowHeight = 250
        sportsTableView.rowHeight = UITableView.automaticDimension
    }


    // MARK: - UITableView Delegate methods

    /// Sets the table view cell height to automatic
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }


    /// Returns the number of the cells in each section.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homescreenViewModel.getSportsCount()
    }


    /// Sets the table view cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var sportCell = tableView.dequeueReusableCell(withIdentifier: "sportCell") as! SportCellController
        sportCell = homescreenViewModel.setupSportCell(cell: sportCell, index: indexPath.row)
        return sportCell
    }


    /// Expands or collapses the sport cell when the user taps on it.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedCell = tableView.cellForRow(at: indexPath) as! SportCellController
        homescreenViewModel.expandCollapseCell(cell: selectedCell, index: indexPath.row)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
