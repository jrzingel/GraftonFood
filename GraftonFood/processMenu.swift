//
//  processMenu.swift
//  GraftonFood
//
//  Created by James on 24/07/21.
//

import Foundation

// Load the CSV file and extract the correct infomation from it
struct Day {
    var num: Int  // Correct day num
    var lunch: String  // Menu items
    var lunch_veg: String
    var lunch_treat: String
    var dinner_a: String
    var dinner_b: String
    var dinner_veg: String
    var dinner_desert: String
}

func getNextMealBody(_ time: Date) -> String {
    // For the moment just get lunch for the day
    let days = convertCSVIntoArray()
    var mealNum:Int = toWeek(time) % 42
    var today = days[mealNum]
    
    let afterLunch = Calendar.current.date(bySettingHour: 13, minute: 30, second: 0, of: time)!
    let afterDinner = Calendar.current.date(bySettingHour: 19, minute: 0, second: 0, of: time)!
    
    if time <= afterLunch {
        // Its before lunch
        return today.lunch + " w " + today.lunch_treat
    } else if time <= afterDinner {
        // Its before dinner
        return today.dinner_a + " & " + today.dinner_b
    } else {
        // Its after dinner (Look at next day)
        mealNum = (mealNum + 1) % 42
        today = days[mealNum]
        return today.lunch + " w " + today.lunch_treat
    }
}

func getNextMealTitle(_ time: Date) -> String {
    // Return the title for meal (Lunch/Dinner)
    let afterLunch = Calendar.current.date(bySettingHour: 13, minute: 30, second: 0, of: time)!
    let afterDinner = Calendar.current.date(bySettingHour: 19, minute: 0, second: 0, of: time)!
    
    if time <= afterLunch {
        // Its before lunch
        return "Lunch"
    } else if time <= afterDinner {
        // Its before dinner
        return "Dinner"
    } else {
        // Its after dinner (Look at next day)
        return "Lunch Tmrw"
    }
}

func toWeek(_ date:Date) -> Int {
    // Convert from date object to the correct week and day
    
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd HH:mm"
    let first = df.date(from: "2021/06/28 00:00")  // First day of semester 2
    
    let day = Calendar.current.dateComponents([.day], from: first!, to: date).day
    return day!
}

func convertCSVIntoArray() -> Array<Day> {
    var days = [Day]()  // Array of all the days

    //let file = "GraftonFood/menu.csv"
    let filePath = Bundle.main.path(forResource: "menu", ofType: ".csv")!
    var data = ""
    do {
        data = try String(contentsOfFile: filePath, encoding: .utf8)
    } catch {
        print(error)
    }
    
    //now split that string into an array of "rows" of data.  Each row is a string.
    var rows = data.components(separatedBy: "\n")

    //if you have a header row, remove it here
    rows.removeFirst()

    //now loop around each row, and split it into each of its columns
    for row in rows {
        let columns = row.components(separatedBy: ",")
        //check that we have enough columns
        if columns.count == 8 {
            let num = Int(columns[0]) ?? 0
            let person = Day(num: num, lunch: columns[1], lunch_veg: columns[2], lunch_treat: columns[3], dinner_a: columns[4], dinner_b: columns[5], dinner_veg: columns[6], dinner_desert: columns[7])
            days.append(person)
        }
    }
    return days
}
