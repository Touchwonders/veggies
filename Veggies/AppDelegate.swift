//
//  AppDelegate.swift
//  Veggies
//
//  Created by RHLJH Hooijmans on 21/08/15.
//  Copyright © 2015 Robert-Hein Hooijmans. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Fabric.with([Crashlytics.self()])
        
        let rootViewController = ViewController()
        rootViewController.title = "Veggies"
        
        navigationController = UINavigationController(rootViewController: rootViewController)
        if let navigationController = navigationController {
            navigationController.navigationBar.translucent = true
            navigationController.navigationBar.barTintColor = nil
            navigationController.navigationBar.backgroundColor = nil
            navigationController.navigationBar.opaque = false
            
            navigationController.navigationBar.setTitleVerticalPositionAdjustment(5.0, forBarMetrics: .Default)
            navigationController.navigationBar.titleTextAttributes = [
                NSFontAttributeName: UIFont(name: "MoonFlowerBold", size: 36)!,
                NSForegroundColorAttributeName: Statics.TintColor
            ]
        }
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        if let window = window {
            window.backgroundColor = .whiteColor()
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
        
        return true
    }
}

