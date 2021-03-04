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
    
    func sendNotification(title: String, subtitle: String?, body: String, launchIn: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Abgabe Termin!"
        content.subtitle = "Im Fach \(subtitle ?? "") muss die Aufgabe \(title) abgegeben werden!"
        content.sound = UNNotificationSound.default
        
        
        // define the time when the notification will be called
        var dateComponents = DateComponents()
        dateComponents.hour = Calendar.current.component(.hour, from: launchIn)
        dateComponents.minute = Calendar.current.component(.minute, from: launchIn)
        dateComponents.month = Calendar.current.component(.month, from: launchIn)
        dateComponents.day = Calendar.current.component(.day, from: launchIn)
        dateComponents.weekOfMonth = Calendar.current.component(.weekOfMonth, from: launchIn)
        dateComponents.year = Calendar.current.component(.year, from: launchIn)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
}
