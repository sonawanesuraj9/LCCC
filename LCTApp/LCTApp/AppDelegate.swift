//
//  AppDelegate.swift
//  LCTApp
//
//  Created by Suraj MAC2 on 3/19/16.
//  Copyright © 2016 supaint. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var deviceHeight : CGFloat = CGFloat()
    var udidString : String    = String()
    var deviceTokenToSend : String = String()
    var baseUrl : String = String()
    
    //Appearence
    
    let roundedCorner : CGFloat = 5

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        baseUrl = " http://supraint.com/works/lct/html/webservices/"
        //Get device UDID
        udidString = UIDevice.currentDevice().identifierForVendor!.UUIDString
        print("UDID:\(udidString)")
        
        //Mannually override IQKeyboardManager
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = false

        deviceHeight = UIScreen.mainScreen().bounds.size.height
        
        //Remote Notification Code
       // self.initializeNotificationSetting()

        
        return true
    }

//TODO: - Remote Notification Initialization
    
    func initializeNotificationSetting(){
        //Remote Notification Code
        let setting = UIUserNotificationSettings(forTypes: [.Sound,.Badge,.Alert], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(setting)
        UIApplication.sharedApplication().registerForRemoteNotifications()
    }
    
//TODO: - Remote Notification Delegate Method
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        let characterSet: NSCharacterSet = NSCharacterSet( charactersInString: "<>" )
        let deviceTokenString: String = ( deviceToken.description as NSString )
            .stringByTrimmingCharactersInSet( characterSet )
            .stringByReplacingOccurrencesOfString( " ", withString: "" ) as String
        print(" deviceTokenString : \(deviceTokenString)" )
        deviceTokenToSend = deviceTokenString
        NSNotificationCenter.defaultCenter().postNotificationName("GotDeviceToken", object: nil)
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print(error.localizedDescription)
    }

    
//TODO: - Function
    
    func displayAlert(alertTitle:String,msg:String){
        let alert = UIAlertController(title: "", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
        
        self.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

