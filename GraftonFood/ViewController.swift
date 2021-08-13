//
//  ViewController.swift
//  GraftonFood
//
//  Created by James on 24/07/21.
//

import UIKit
import Foundation
import UserNotifications

class ViewController: UIViewController {
    // Get the menu items

    var menuController : MenuController?  // Able to access the child
    
    @IBOutlet weak var MenuView: UIView!
    
    @IBOutlet weak var dayOfWeek: UILabel!
    
    // Get the date
    @IBOutlet weak var date: UIDatePicker!
    
    // Run when the date changes
    @IBAction func dateChanged(_ sender: Any) {
        changeMenu()
    }
    
    @IBAction func todayPress(_ sender: Any) {
        // Today button has been pressed, so set date to now
        date.date = Date()
        changeMenu()
    }
    
    func changeMenu() {
        let days = convertCSVIntoArray()
        let mealNum:Int = toWeek(date.date) % 42
        
        let day = days[mealNum]
        //dinner_a.text = day.dinner_a
        //dinner_b.text = day.dinner_b
        //dinner_veg.text = day.dinner_veg
        //dinner_desert.text = day.dinner_desert
        
        // Get the correct day of the week shown
        let f = DateFormatter()
        dayOfWeek.text = f.weekdaySymbols[Calendar.current.component(.weekday, from: date.date) - 1]
        
        //self.delegate?.setMenu(day)
        //s.setMenu(day);
        
        //let menuContoller = storyboard!.instantiateViewController(withIdentifier: "Menu Table") as! MenuController
        //menuContoller.setMenu(day)
        
        //if let delegate = delegate {
        //    delegate.updateMenu()
        //}
        
        menuController?.lunch.text = day.lunch
        menuController?.lunchTreat.text = day.lunch_treat
        menuController?.lunchVeg.text = day.lunch_veg
        menuController?.dinnerA.text = day.dinner_a
        menuController?.dinnerB.text = day.dinner_b
        menuController?.dinnerDesert.text = day.dinner_desert
        menuController?.dinnerVeg.text = day.dinner_veg
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) {
            (granted, error) in
            if granted {
                print("ya")
            } else {
                print("Nah")
            }
        }
        
        print(self.children)
        // Grab child controller
        menuController = self.children[0] as? MenuController
        
        changeMenu()
    }
}
