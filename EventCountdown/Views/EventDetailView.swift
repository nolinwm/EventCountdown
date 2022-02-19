//
//  EventDetailView.swift
//  EventCountdown
//
//  Created by Nolin McFarland on 2/19/22.
//

import SwiftUI

struct EventDetailView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    let event: Event?
    
    @State var name: String
    @State private var date: Date = Date.midnightTomorrow()
    @State private var color: Color = .blue
    
    private var saveDisabled: Bool {
        return name.isEmpty || date <= Date.now
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                
                Spacer()
                
                Button("Save") {
                    saveEvent()
                }
                .disabled(saveDisabled)
            }
            .padding()
            .background(Color(uiColor: .systemGray6))
            
            Form {
                TextField("Event Name", text: $name)
                    .font(.headline)
                    .padding(10)
                DatePicker("Occurs", selection: $date)
                    .padding(10)
                ColorPicker("Color", selection: $color, supportsOpacity: false)
                    .padding(10)
            }
            .onAppear {
                if let event = event {
                    if let eventDate = event.date {
                        self.date = eventDate
                    }
                    if let eventColorAsHex = event.colorAsHex {
                        self.color = Color(hex: eventColorAsHex)
                    }
                }
            }
        }
        .accentColor(color)
    }
    
    func saveEvent() {
        if let event = event {
            event.name = self.name
            event.date = self.date
            event.colorAsHex = Color.convertToHex(self.color)
        } else {
            let newEvent = Event(context: moc)
            newEvent.name = self.name
            newEvent.date = self.date
            newEvent.colorAsHex = Color.convertToHex(self.color)
        }
        
        try? moc.save()
        dismiss()
    }
}

// TODO: Add preview supporting CoreData
//struct EventDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventDetailView()
//    }
//}