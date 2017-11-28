//
//  AppDelegate.swift
//  iOS_OAuth2Test
//
//  Created by Taylor Newton on 4/20/17.
//  Copyright © 2017 Taylor Newton. All rights reserved.
//

import UIKit
import AppAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var currentAuthorizationFlow: OIDAuthorizationFlowSession?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let viewController = ViewController()
        
        self.window?.rootViewController = viewController;
        self.window?.makeKeyAndVisible();
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
        // this hits when you successfully open up the redirect uri from the safari view controller
        if currentAuthorizationFlow!.resumeAuthorizationFlow(with: url) {
            currentAuthorizationFlow = nil
            return true
        }
        return false
    }
    
    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

    }
}

