//
//  NotificationHandler.swift
//  EventCountdown
//
//  Created by Nolin McFarland on 2/19/22.
//

import Foundation
import UserNotifications

struct NotificationHandler {
    
    static let shared = NotificationHandler()
    
    func scheduleNotification(eventId: UUID, eventName: String, eventDate: Date) {
        let content = UNMutableNotificationContent()
        content.title = "\(eventName)"
        content.body = "Event has occurred!"
        content.sound = UNNotificationSound.default
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: eventDate),
            repeats: false
        )
        
        let request = UNNotificationRequest(identifier: eventId.uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func removeNotification(eventId: UUID) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [eventId.uuidString])
    }
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
