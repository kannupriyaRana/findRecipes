//
//  NotificationPublisher.swift
//  findRecipe
//
//  Created by Administrator on 18/02/22.
//

import UserNotifications
import UIKit

class NotificationPublisher: NSObject {
    
    
    func sendNotification(title: String, subtitle: String, body: String, badge: Int?, delayInterval: Int? ) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.subtitle = subtitle
        notificationContent.body = body
        
        var delayTimeTrigger: UNTimeIntervalNotificationTrigger?
        if let delayInterval = delayInterval {
            delayTimeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(delayInterval), repeats: false)
        }
        
        if let badge = badge {
            var currentBadgeCount = UIApplication.shared.applicationIconBadgeNumber
            currentBadgeCount += badge
            notificationContent.badge = NSNumber(integerLiteral: currentBadgeCount)
        }
        notificationContent.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: "SaveRecipeNotification", content: notificationContent, trigger: delayTimeTrigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error)
            }
            else {
                print("Successfuly received")
            }
        }
        
    }
}
