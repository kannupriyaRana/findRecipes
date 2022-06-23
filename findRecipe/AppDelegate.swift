//
//  AppDelegate.swift
//  findRecipe
//
//  Created by Administrator on 05/02/22.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("tHE NOTIFICATION IS ABOUT OT BE PRESENTED")
        completionHandler([.badge, .sound, .alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let identifier = response.actionIdentifier
        
        switch identifier {
        case UNNotificationDismissActionIdentifier :
            print("The notification was dismissed")
            completionHandler()
            
        case UNNotificationDefaultActionIdentifier :
            print("The user opened the app from notification")
            completionHandler()
            
        default:
            print("The default case was called")
            completionHandler()
        }
    }
    
    private func requestNotificationAuthorization(application: UIApplication) {
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        center.requestAuthorization(options: options) { granted, error in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                print("Notification permission is given successfully ")
            }
        }
        

    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        UNUserNotificationCenter.current().delegate = self
        requestNotificationAuthorization(application: application)
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

