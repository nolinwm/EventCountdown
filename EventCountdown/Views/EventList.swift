//
//  EventList.swift
//  EventCountdown
//
//  Created by Nolin McFarland on 2/19/22.
//

import SwiftUI

struct EventList: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \Event.date, ascending: false)
    ]) var events: FetchedResults<Event>
    
    private var activeEvents: [Event] {
        return events.filter {
            $0.date != nil && $0.date! > Date.now
        }
    }
    
    private var pastEvents: [Event] {
        return events.filter {
            $0.date != nil && $0.date! <= Date.now
        }
    }
    
    @State private var showingModal = false
    
    var body: some View {
        List {
            ForEach(activeEvents) { event in
                NavigationLink {
                    EventView(event: event)
                } label: {
                    EventRow(event: event)
                }
            }
            .onDelete(perform: deleteEvents)
            
            if pastEvents.count > 0 {
                Section("Past") {
                    ForEach(pastEvents) { event in
                        NavigationLink {
                            EventView(event: event)
                        } label: {
                            EventRow(event: event)
                        }
                    }
                    .onDelete(perform: deleteEvents)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingModal = true
                } label: {
                    Label("Add Event", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showingModal) {
            EventDetailView(event: nil, name: "")
        }
    }
    
    func deleteEvents(at offsets: IndexSet) {
        for index in offsets {
            let event = events[index]
            NotificationHandler.shared.removeNotification(eventId: event.id!)
            moc.delete(event)
        }
        
        try? moc.save()
    }
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        EventList()
    }
}
