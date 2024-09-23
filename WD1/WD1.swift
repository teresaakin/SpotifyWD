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
        HStack(alignment: .top, spacing: 18) {
            // Album cover art placeholder
            ZStack(alignment: .topTrailing) {
                Image(.mtsSwift)
                    .resizable()
                    .frame(width:60, height:60)
                    .cornerRadius(6)
//                RoundedRectangle(cornerRadius: 6)
//                    .fill(Color.gray)
//                    .frame(width: 60, height: 60)
               
                ZStack{

                        // pfp placeholder

                        Image(.arcPfp)
                            .resizable() // Allows the image to be resized
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(4)
                            .frame(width: 25, height: 25) // Set the frame size for cropping
                            .clipShape(RoundedRectangle(cornerRadius: 4)) // clips image to the rounded shape
                            .clipped() // This ensures that only the part of the image inside the frame is displayed
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.black, lineWidth: 2)
                            )

                } .offset(x: 8, y: 40)
                
                
            }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("LISTENING TO...")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(.gray)
                        
                        Text("Reminders")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Text("Mariah The Scientist")
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.9))
                    }
                    
                    Spacer()
                    
                    // Spotify logo
                    Image(.spotifyLogo)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .offset(y: -16) // Move the logo up by adjusting the y axis offset

                }
                
                Spacer()
                
                // Emoji reactions
                HStack(spacing: 8) {
                    Spacer() // pushes emoji list to the right
                    ForEach(["❤️", "🔥", "😂", "👎"], id: \.self) { emoji in
                        ZStack {
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 30, height: 30)
                            Text(emoji)
                                .font(.system(size: 12))
                        }
                    }
                }
            }
            .padding(.trailing, 10) // Add padding to the right for better alignment
        }
        .padding(6) // gives the layout a solid feel
        .containerBackground(Color.black, for: .widget)
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
