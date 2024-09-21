//
//  WD1.swift
//  WD1
//
//  Created by Teresa Akinbodun on 2024-09-19.
//


// WD1 = widgetDesign1
import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entries = [SimpleEntry(date: Date())]
        let timeline = Timeline(entries: entries, policy: .atEnd) // Fixed: Timeline, not TimeLine
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct WD1EntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Color.clear
            HStack(spacing: 18) {
                ZStack {
            
                    // album art placeholder
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.gray)
                                .frame(width: 60, height: 60)
                                .padding(.top, -30) // Negative padding to move it up
                    
                    // pfp placeholder on top of the album art
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.white)
                        .frame(width: 25, height: 25)
                        .offset(x: 25, y: 10)
                }
                .padding(.leading, 10)
                
        
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("LISTENING TO...")
                        .font(.system(size: 8, weight: .semibold))
                        .foregroundColor(.gray)
                        .padding(.top, -16) // Negative padding to move it up
                    
                    Text("Reminders")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, -8) // Negative padding to move it up
                    
                    
                    Text("Mariah The Scientist")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                    
                    HStack(spacing: 12) {
                        Text("❤️")
                            .font(.system(size: 16))
//                        Image(systemName: "flame.fill")
//                        Image(systemName: "face.smiling.fill")
//                        Image(systemName: "hand.thumbsdown.fill")
                    }
                    .foregroundColor(.gray)
                }
                Spacer()
                
                // spotify logo placeholder //fix this! use stacks
                Circle()
                    .fill(Color.green)
                    .frame(width: 20, height: 20)
                    .padding(.top, -50) // Negative padding to move it up
                    
            }

        }
        .containerBackground(Color.black, for: .widget) // Optional: Use system background for the widget

    }
}

@main
struct WD1: Widget {
    let kind: String = "WD1"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WD1EntryView(entry: entry)
        }
        .configurationDisplayName("Spotify Widget")
        .description("Friend's listening activity")
        .supportedFamilies([.systemMedium])
    }
}


struct WD1_Previews: PreviewProvider {
    static var previews: some View {
        WD1EntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
