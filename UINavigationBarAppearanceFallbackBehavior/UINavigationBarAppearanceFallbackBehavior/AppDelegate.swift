//
//  AppDelegate.swift
//  UINavigationBarAppearanceFallbackBehavior
//
//  Created by Robin Kunde on 1/6/20.
//  Copyright © 2020 Recoursive.com. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = UIColor.red
        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.blue,
        ]
        navBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.blue,
        ]

        let appearanceProxy = UINavigationBar.appearance()
        appearanceProxy.standardAppearance = navBarAppearance

        // 2. setting the appearance on scrollEdgeAppearance fixes the issue, even though fallback behavior says
        // standardAppearance should be used if it is not
//        appearanceProxy.scrollEdgeAppearance = navBarAppearance

        let primaryContentVC = UIViewController()
        primaryContentVC.view.backgroundColor = UIColor.green
        primaryContentVC.title = "navBar background should be red"
        let primaryNavigationVC = UINavigationController(rootViewController: primaryContentVC)
        // 1. if prefersLargeTitles is enabled on the primary navigation controller bar, the navBars of both primary
        // and secondary view become completely transparent (not translucent)
        primaryNavigationVC.navigationBar.prefersLargeTitles = true

        let secondaryContentVC = UIViewController()
        secondaryContentVC.view.backgroundColor = UIColor.green
        secondaryContentVC.title = "navBar background should be red"
        let secondaryNavigationVC = UINavigationController(rootViewController: secondaryContentVC)
        // 3. if prefersLargeTitles is enabled only on the secondary navigation controller bar, only the navBar of the
        // secondary view becomes completely transparent (not translucent)
//        detailNavVC.navigationBar.prefersLargeTitles = true

        let splitVC = UISplitViewController()
        splitVC.viewControllers = [primaryNavigationVC, secondaryNavigationVC]

        let window = UIWindow()
        window.rootViewController = splitVC
        window.makeKeyAndVisible()
        self.window = window

        return true
    }
}
