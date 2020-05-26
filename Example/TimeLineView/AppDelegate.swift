//
//  AppDelegate.swift
//  TimeLineView
//
//  Created by iamasimkhanjadoon@gmail.com on 05/25/2020.
//  Copyright (c) 2020 iamasimkhanjadoon@gmail.com. All rights reserved.
//

import UIKit
import TimeLineView

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var years_array = ["2020","2019", "2018", "2017", "2016", "2014", "2013", "2012", "2011", "2010", "2009", "2008" ]
    var months_array = ["December", "November", "October", "September", "August", "July", "June", "May", "April", "March", "Febuary", "January"]
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let historyTVC = TimeLineViewController()
        historyTVC.title = "History View"
        historyTVC.timelineTitles = self.years_array
        historyTVC.timelineSubTitles = self.months_array
        historyTVC.timelineItems = [
            ["name":"Title","image_url":"https://image.flaticon.com/icons/png/512/2922/2922553.png",],
            ["name":"Title","image_url":"https://image.flaticon.com/icons/png/512/2922/2922553.png",],
            ["name":"Title","image_url":"https://image.flaticon.com/icons/png/512/2922/2922553.png",],
            ["name":"Title","image_url":"https://image.flaticon.com/icons/png/512/2922/2922553.png",],
            ["name":"Title","image_url":"https://image.flaticon.com/icons/png/512/2922/2922553.png",],
        ]
        
        historyTVC.titleBackground = UIColor.red
        historyTVC.titleTint = UIColor.white
        
        historyTVC.subTitleBackground = UIColor.orange
        historyTVC.subTitleTint = UIColor.white
        
        let navigationController = UINavigationController(rootViewController: historyTVC)
        
        
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

