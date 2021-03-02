//
//  NotificationHanler.swift
//  HomeWorkPlanner (iOS)
//
//  Created by Marvin Hülsmann on 02.03.21.
//

import Foundation
import SwiftUI

class NotificationHandler: ObservableObject {
    
    var notifications = [Notification]()
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted == true && error == nil {
                print("Notifications permitted")
            } else {
                print("Notifications not permitted")
            }
        }
    }
    
    func sendNotification(title: String, subtitle: String?, body: String, launchIn: Double) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle ?? ""
        content.sound = UNNotificationSound.defaultCritical

        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: launchIn, repeats: false)
        
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
}
