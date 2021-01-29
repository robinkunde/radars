//
//  ViewController.swift
//  formSheetStackRadar
//
//  Created by Robin Kunde on 3/11/20.
//  Copyright © 2020 Recoursive. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(title: "cancel", style: .done, target: self, action: #selector(dismissStack))
        ]
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "cancel", style: .done, target: self, action: #selector(dismissStack))
        ]
    }

    @IBAction func addStack(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
        // 1. use an initializer that does not cause UINavigationController to immediately call loadView()
        let nvc = UINavigationController()
        // 2. cause the UINavigationController's UINavigationBar to be initialized before loadView() is called
        nvc.navigationBar.tintColor = .black
        // 3. set rootViewController in some other way
        nvc.viewControllers = [vc]

        present(nvc, animated: true, completion: nil)
    }

    @objc
    private func dismissStack() {
        dismiss(animated: true, completion: nil)
    }
}

