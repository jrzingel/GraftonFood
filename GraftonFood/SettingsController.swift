//
//  SettingsController.swift
//  GraftonFood
//
//  Created by James on 25/07/21.
//

import Foundation
import UIKit

// View Controller for settings scene
class SettingsController: UIViewController {
    // DO stuff here
    
    // Schedule notifications
    @IBAction func scheduleNotifications(_ sender: Any) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        for i in 1...7 {
            print(i)
            createNotifications(day: i)
        }
    }
    
    func getLunch(day: Int) -> String {
        let days = convertCSVIntoArray()
        let mealNum:Int = day % 42
        let day = days[mealNum]
        let lunch = day.lunch
        return lunch
    }
    
    func getSpecialTreat(day: Int) -> String {
        let days = convertCSVIntoArray()
        let mealNum:Int = day % 42
        let day = days[mealNum]
        let treat = day.lunch_treat
        return treat
    }
    
    func getDinnerA(day: Int) -> String {
        let days = convertCSVIntoArray()
        let mealNum:Int = day % 42
        let day = days[mealNum]
        let meal = day.dinner_a
        return meal
    }
    
    func getDinnerB(day: Int) -> String {
        let days = convertCSVIntoArray()
        let mealNum:Int = day % 42
        let day = days[mealNum]
        let meal = day.dinner_b
        return meal
    }
    
    func getDesert(day: Int) -> String {
        let days = convertCSVIntoArray()
        let mealNum:Int = day % 42
        let day = days[mealNum]
        let meal = day.dinner_desert
        return meal
    }
    
    func createNotifications(day:Int) {
        let notificationCenter = UNUserNotificationCenter.current()
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        //notificationCenter.removeAllDeliveredNotifications()
        
        // For lunch
        let lunchContent = UNMutableNotificationContent()
        lunchContent.title = "Lunch today:"
        lunchContent.body = getLunch(day: day) + " with a special treat of " + getSpecialTreat(day: day)
        lunchContent.categoryIdentifier = "info"
        lunchContent.sound = UNNotificationSound.default
        
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 61, repeats: true)
        // For a time in the morning, needs to be Optional(2021-07-26 21:00:00 +0000)
        // For a time in the evening, needs to be Optional(2021-07-26 09:28:58 +0000)
        
        let old_lunchTime = calendar.date(bySettingHour: 21, minute: 0, second: 0, of: Date())!
        let lunchTime = calendar.date(byAdding: .day, value: day, to: old_lunchTime)!
        let comps = calendar.dateComponents([.year, .month, .day, .hour], from: lunchTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
        //print(Date(), "|", trigger.nextTriggerDate(), "|", old_lunchTime, "|", comps)
        
        
        print(trigger.nextTriggerDate())
        
        let request = UNNotificationRequest(identifier: "lunchAlert", content: lunchContent, trigger: trigger)
        notificationCenter.add(request) {(error) in
            if let error = error {
                print("Uh oh! We had an error: \(error)")
            }
        }
        
        /*
        // For dinner
        let dinnercontent = UNMutableNotificationContent()
        dinnercontent.title = "Dinner tonight:"
        dinnercontent.body = getDinnerA(day: day) + " and " + getDinnerB(day: day) + " with a desert of " + getDesert(day: day)
        dinnercontent.sound = UNNotificationSound.default
             
        let dinnerTime = Calendar.current.date(byAdding: dayAhead, to: Calendar.current.date(bySettingHour: 5, minute: 0, second: 0, of: Date())!)!
        comps = Calendar.current.dateComponents([.year, .month, .day], from: dinnerTime)
        trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
        print(trigger.nextTriggerDate())
        request = UNNotificationRequest(identifier: uuidString, content: dinnercontent, trigger: trigger)
        notificationCenter.add(request, withCompletionHandler: nil)
        
        //let new_trig = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        //request = UNNotificationRequest(identifier: "notification.id.02", content: content, trigger: new_trig)
        //UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup needed to be done
    }
}
