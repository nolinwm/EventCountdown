//
//  EventList.swift
//  EventCountdown
//
//  Created by Nolin McFarland on 2/19/22.
//

import SwiftUI

struct EventList: View {
    
    @FetchRequest(sortDescriptors: []) var events: FetchedResults<Event>
    
    @State private var showingModal = false
    
    var body: some View {
        List {
            ForEach(events) { event in
                NavigationLink {
                    EventView(event: event)
                } label: {
                    EventRow(event: event)
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
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        EventList()
    }
}