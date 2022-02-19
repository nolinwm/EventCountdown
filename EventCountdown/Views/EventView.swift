//
//  EventView.swift
//  EventCountdown
//
//  Created by Nolin McFarland on 2/19/22.
//

import SwiftUI

struct EventView: View {
    
    let event: Event
    
    var columns: [GridItem] =
             Array(repeating: .init(.flexible()), count: 2)
    
    @State private var showModal = false
    
    let timer = RefreshTimer()
    @State private var refreshToggle: Bool = false
    
    var countdown: DateComponents {
        return Date.countdown(event.date ?? Date.now)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Label("\(event.date ?? Date.now, format: .dateTime.month().day().year())", systemImage: "calendar")
                            .font(.title2)
                        Label("\(event.date ?? Date.now, format: .dateTime.hour().minute())", systemImage: "clock")
                            .font(.title2)
                    }
                    .padding()
                    Spacer()
                }
                
                LazyVGrid(columns: columns) {
                    Group {
                        TimeCard(color: Color(hex: event.colorAsHex), label: "Years", value: countdown.year!, delay: 0)
                        TimeCard(color: Color(hex: event.colorAsHex), label: "Months", value: countdown.month!, delay: 0.15)
                        TimeCard(color: Color(hex: event.colorAsHex), label: "Days", value: countdown.day!, delay: 0.3)
                        TimeCard(color: Color(hex: event.colorAsHex), label: "Hours", value: countdown.hour!, delay: 0.45)
                        TimeCard(color: Color(hex: event.colorAsHex), label: "Minutes", value: countdown.minute!, delay: 0.6)
                        TimeCard(color: Color(hex: event.colorAsHex), label: "Seconds", value: countdown.second!, delay: 0.75)
                    }
                    .padding(10)
                }
                .padding(10)
                
                // Allows for the refresh timer to refresh the countdown
                Text(refreshToggle ? "" : "")
                    .hidden()
            }
        }
        .sheet(isPresented: $showModal, onDismiss: {
            showModal = false
        }, content: {
            EventDetailView(event: event, name: event.name ?? "")
        })
        .onReceive(timer.currentTimePublisher) { newCurrentTime in
            self.refreshToggle.toggle()
        }
        .navigationTitle(event.name ?? "Event")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showModal = true
                } label: {
                    Label("Edit", systemImage: "pencil")
                        .foregroundColor(Color(hex: event.colorAsHex))
                }
            }
        }
    }
}

// TODO: Add preview supporting CoreData
//struct EventView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventView()
//    }
//}
