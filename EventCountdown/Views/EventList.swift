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
            .onDelete(perform: deleteActiveEvents)
            
            if pastEvents.count > 0 {
                Section("Past") {
                    ForEach(pastEvents) { event in
                        NavigationLink {
                            EventView(event: event)
                        } label: {
                            EventRow(event: event)
                        }
                    }
                    .onDelete(perform: deletePastEvents)
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
    
    func deleteActiveEvents(at offsets: IndexSet) {
        for index in offsets {
            let event = activeEvents[index]
            deleteEvent(event: event)
        }
        try? moc.save()
    }
    
    func deletePastEvents(at offsets: IndexSet) {
        for index in offsets {
            let event = pastEvents[index]
            deleteEvent(event: event)
        }
        try? moc.save()
    }
    
    func deleteEvent(event: Event) {
        NotificationHandler.shared.removeNotification(eventId: event.id!)
        moc.delete(event)
    }
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        EventList()
    }
}
