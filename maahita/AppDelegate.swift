//
//  AppDelegate.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 01/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit
import Firebase
import JitsiMeetSDK
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    
    override init() {
        super.init()
        UIFont.overrideInitialize()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { (_, _) in
            
        }
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        Messaging.messaging().isAutoInitEnabled = true
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
          
        /// To remove support for dark mode
        if #available(iOS 13.0, *) {
            self.window?.overrideUserInterfaceStyle = .light
        }
        
        let firebaseAuth = Auth.auth()
        if let user = firebaseAuth.currentUser, !user.isAnonymous {
            UserDefaults.standard.set(user.email, forKey: Strings.EMAIL_ID)
        } else {
            UserDefaults.standard.set(nil, forKey: Strings.EMAIL_ID)
            firebaseAuth.signInAnonymously { (authData, error) in }
        }
        
        self.window?.rootViewController = SessionsViewController()
        
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        //return JitsiMeet.sharedInstance().application(application, continue: userActivity, restorationHandler: restorationHandler)
        
        let handled = DynamicLinks.dynamicLinks().handleUniversalLink(userActivity.webpageURL!) { (dynamiclink, error) in
            print(dynamiclink?.url?.absoluteString)
        }

        return handled
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        //return JitsiMeet.sharedInstance().application(app, open: url, options: options)
        if let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url) {
          // Handle the deep link. For example, show the deep-linked content or
          // apply a promotional offer to the user's account.
          // ...
          return true
        }
        return false
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
      if let rootViewController = self.topViewControllerWithRootViewController(rootViewController: window?.rootViewController) {
        if (rootViewController.responds(to: Selector(("canRotate")))) {
          // Unlock landscape view orientations for this view controller
          return .allButUpsideDown;
        }
      }
      
      // Only allow portrait (standard behaviour)
      return .portrait;
    }
    
    private func topViewControllerWithRootViewController(rootViewController: UIViewController!) -> UIViewController? {
      if (rootViewController == nil) { return nil }
      if (rootViewController.isKind(of: UITabBarController.self)) {
        return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UITabBarController).selectedViewController)
      } else if (rootViewController.isKind(of: UINavigationController.self)) {
        return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UINavigationController).visibleViewController)
      } else if (rootViewController.presentedViewController != nil) {
        return topViewControllerWithRootViewController(rootViewController: rootViewController.presentedViewController)
      }
      return rootViewController
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        UserDefaults.standard.set(fcmToken, forKey: "deviceToken")
    }
}

//extension AppDelegate: MessagingDelegate {
//    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
//    }
//
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
//        UserDefaults.standard.set(fcmToken, forKey: "deviceToken")
//    }
//}
