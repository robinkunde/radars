//
//  AppDelegate.swift
//  UISearchBarSearchTextFieldAppearanceProxy
//
//  Created by Robin Kunde on 11/4/19.
//  Copyright © 2019 Recoursive. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // last tested Xcode 11.3, iOS 13.3

        let appearance = UISearchBar.appearance()
        appearance.showsCancelButton = true // works
        // bar background color
        appearance.backgroundColor = UIColor.green // works for UISearchController bar, but free UISearchBar effect is very subtle if translucent, otherwise only affects top and bottom border
        // set placeholder
        appearance.placeholder = "search1" // works
        appearance.searchTextField.placeholder = "search2" // does not work
        // cancel button text color
        appearance.tintColor = UIColor.red // works, unless barTintColor is set, also changes text field text caret color
        //
        appearance.barTintColor = UIColor.brown // works for free UISearchBar, but not UISearchController bar, also overrides tintColor effects on cancel button

        // change text field text color
        appearance.searchTextField.textColor = UIColor.blue // does not work
        // change text field text font
        appearance.searchTextField.font = UIFont.systemFont(ofSize: 24.0) // does not work
         // change text caret color
        appearance.searchTextField.tintColor = UIColor.black // does not work
         // yellow background
        appearance.searchTextField.backgroundColor = UIColor.yellow // does not work

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

