//
//  ViewController.swift
//  RadarColorAssetReset
//
//  Created by Robin Kunde on 7/23/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class Label: UILabel {
    var isViewLoaded = false

    override var textColor: UIColor! {
        willSet {
            if let newValue = newValue, isViewLoaded {
                // set breakpoint here to observe when UIKit resets the color after viewDidLoad occured
                print(newValue)
            }
        }
    }
}

class ViewController: UIViewController {
    @IBOutlet var testLabel: Label!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        testLabel.textColor = UIColor.green
        testLabel.isViewLoaded = true
    }
}
