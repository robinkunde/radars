//
//  ViewController.swift
//  UISearchBarSearchTextFieldAppearanceProxy
//
//  Created by Robin Kunde on 11/4/19.
//  Copyright © 2019 Recoursive. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        navigationItem.searchController = searchController

        //
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            searchBar.widthAnchor.constraint(equalToConstant: 320.0),
            searchBar.heightAnchor.constraint(equalToConstant: 44.0),
        ])
    }
}
