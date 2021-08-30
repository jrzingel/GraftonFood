//
//  GraftonFoodWidget.swift
//  GraftonFoodWidget
//
//  Created by James on 25/07/21.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    public typealias Entry = SimpleEntry
    
    // For before the widget has been loaded. (Or locked and not allowed access)
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), title: getNextMealTitle(Date()), body: getNextMealBody(Date()))
    }

    // Used for widget gallery and such
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), title: getNextMealTitle(Date()), body: getNextMealBody(Date()))
        completion(entry)
    }
    
    // Timeline entry for when to update the widget
    public func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
            var entries: [SimpleEntry] = []

            // Generate a timeline consisting of five entries an hour apart, starting from the current date.
            let currentDate = Date()
            for hourOffset in 0 ..< 5 {
                let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
                let entry = SimpleEntry(
                    date: entryDate,
                    title: getNextMealTitle(entryDate),
                    body: getNextMealBody(entryDate))
                entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    public let title: String
    public let body: String
    //public let dayDetails: Day
}

struct GraftonFoodWidgetEntryView : View {
    //let dayDetails: Day
    var entry: Provider.Entry
    
    var body: some View {
      ZStack {
        Color("background color")
        VStack {
            Text(entry.title)
                .bold()
                //.minimumScaleFactor(0.0005)
                .font(.system(size: 25))
                .scaledToFill()
                .padding(3)
                .minimumScaleFactor(0.5)
                .foregroundColor(Color("text color"))
                
            Text(entry.body)
                .font(.system(size: 18))
                //.multilineTextAlignment(.center)
                //.scaledToFill()
                .lineLimit(5)
                .minimumScaleFactor(0.8)
                .foregroundColor(Color("text color"))
                .padding(3)
        }
        .padding(2)
        .environment(\.sizeCategory, .extraLarge)
      }
    }
}

@main  // Entry point for the widget
struct GraftonFoodWidget: Widget {
    let kind: String = "GraftonFoodWidget"

    var body: some WidgetConfiguration { // Everything goes in here
        StaticConfiguration(
            kind: kind,
            provider: Provider()
        ) { entry in
            GraftonFoodWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Grafton Food Widget")
        .description("Quick and easy way to see what the next meal is.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct GraftonFoodWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GraftonFoodWidgetEntryView(
                entry: SimpleEntry(
                    date: Date(),
                    title: getNextMealTitle(Date()),
                    body: getNextMealBody(Date())))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            GraftonFoodWidgetEntryView(entry: SimpleEntry(date: Date(), title: getNextMealTitle(Date()), body: getNextMealBody(Date())))
                .redacted(reason: /*@START_MENU_TOKEN@*/.placeholder/*@END_MENU_TOKEN@*/)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
