//
//  AppDelegate.swift
//  Pass No Pass
//
//  Created by Adrian on 4/22/17.
//  Copyright © 2017 Adrian. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    override init() {
        FIRApp.configure()  //firebase config
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //facebook sign in
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        //load onboarding screen only once
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "login")
        //checking onboardingComplete or not
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: "onboardingComplete") {
            userpersist()
        } else {
            //otherwise show onboarding view
            window?.rootViewController = initialViewController
            window?.makeKeyAndVisible()
        }

        
        // Override point for customization after application launch.

        UINavigationBar.appearance().barTintColor = UIColor(rgb: 0x40c4ff)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]

        
        return true
    }
    
    //facebook login method
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        return handled
    }
    
    func userpersist() {
        //user persist *** important ***
        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            //check user existence
            if user != nil {
                print("\n***logged in as \(user?.displayName)***")
                let navVC = self.storyboard.instantiateViewController(withIdentifier: "navController") as! UINavigationController
                self.window?.rootViewController = navVC
            } else { //login in if user not found
                print("\n*** Please login ***")
                let navVC = self.storyboard.instantiateViewController(withIdentifier: "login")
                self.window?.rootViewController = navVC
            }
        }
    }

    
    
    
    


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

