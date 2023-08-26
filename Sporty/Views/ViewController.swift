//
//  ViewController.swift
//  Sporty
//
//  Created by Smaro Goulianou on 25/8/23.
//

import UIKit

class ViewController: UIViewController {
    let homescreenViewModel = HomescreenViewModel.sharedInstance

    
    override func viewDidLoad() {
        super.viewDidLoad()

        homescreenViewModel.loadSportEvents()
    }
}
