//
//  HomescreenController.swift
//  Sporty
//
//  Created by Smaro Goulianou on 25/8/23.
//

import UIKit

class HomescreenController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var sportsTableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    let homescreenViewModel = HomescreenViewModel.sharedInstance

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }


    /// Sets up the view.
    func setupView() {
        setupNavigationBar()
        setupTableView()
        loadingIndicator.startAnimating()
        loadViewData()
    }


    /// Sets up the Navigation Bar.
    func setupNavigationBar() {
        setupNavigationBarImage()
        setupNavigationBarColor()
    }


    /// Sets the navigiation bar background colour.
    func setupNavigationBarColor() {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(named: "greenLight")
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            navigationController?.navigationBar.backgroundColor = UIColor(named: "greenDark")
        }
    }


    /// Set the app logo at the Navigation Bar.
    func setupNavigationBarImage() {
        guard let logo = UIImage(named: "titleLogo") else { return }
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }


    /// Registers the custom table view cell and sets the estimated row height.
    func setupTableView() {
        sportsTableView.register(UINib(nibName: "SportCell", bundle: nil), forCellReuseIdentifier: "sportCell")
        sportsTableView.estimatedRowHeight = 250
        sportsTableView.rowHeight = UITableView.automaticDimension
    }


    /// Loads the views' data.
    func loadViewData() {
        homescreenViewModel.loadSportEvents(successCallback: {
            self.loadingIndicator.stopAnimating()
            self.sportsTableView.reloadData()
        }, errorCallBack: {
            self.loadingIndicator.stopAnimating()
            self.homescreenViewModel.errorCallback(alertAction: {
                self.loadViewData()
            })
        })
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
