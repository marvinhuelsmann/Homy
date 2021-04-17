//
//  NotificationHanler.swift
//  HomeWorkPlanner (iOS)
//
//  Created by Marvin Hülsmann on 02.03.21.
//

import Foundation
import SwiftUI

class NotificationHandler: ObservableObject {
    /// current notification
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
    
    /// Get the UNCalendarNotificationTrigger for the notification
    /// - Parameter launchIn: the date when the notification will be launched
    /// - Returns: UNCalendarNotificationTrigger for the request
    private func getTrigger(launchIn: Date) -> UNCalendarNotificationTrigger {
        // define the time when the notification will be called
        var dateComponents = DateComponents()
        dateComponents.hour = Calendar.current.component(.hour, from: launchIn)
        dateComponents.minute = Calendar.current.component(.minute, from: launchIn)
        dateComponents.month = Calendar.current.component(.month, from: launchIn)
        dateComponents.day = Calendar.current.component(.day, from: launchIn)
        dateComponents.weekOfMonth = Calendar.current.component(.weekOfMonth, from: launchIn)
        dateComponents.year = Calendar.current.component(.year, from: launchIn)
        return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    }
    
    /// Send a HomeWork Notification
    /// - Parameters:
    ///   - title: HomeWork name
    ///   - subtitle: HomeWork subject
    ///   - body: Notification body
    ///   - launchIn: HomeWork finish date
    func sendNotification(title: String, subtitle: String?, body: String, launchIn: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Dein Abgabe Termin ist erreicht!"
        content.body = "Im Fach \(subtitle ?? "") muss die Aufgabe \(title) abgegeben werden!"
        content.sound = UNNotificationSound.default
    
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: getTrigger(launchIn: launchIn))

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
    
    /// Send a raw Push Notification
    /// - Parameters:
    ///   - title: Notification title
    ///   - body: Notification body
    ///   - launchIn: Notification will be launched on this date
    func sendNotificationRaw(title: String, body: String, launchIn: Date) {
        let content = UNMutableNotificationContent()
        content.sound = UNNotificationSound.default
        
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: getTrigger(launchIn: launchIn))

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
}
