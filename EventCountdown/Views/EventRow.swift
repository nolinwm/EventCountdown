//
//  EventRow.swift
//  EventCountdown
//
//  Created by Nolin McFarland on 2/19/22.
//

import SwiftUI

struct EventRow: View {
    
    @ObservedObject var event: Event
    
    private var eventIsPast: Bool {
        guard let date = event.date else { return true }
        return date <= Date.now
    }
    
    var body: some View {
        HStack {
            Image(systemName: "circle.fill")
                .foregroundColor(eventIsPast ? .gray : Color(hex: event.colorAsHex))
            Text(event.name ?? "Event")
            Spacer()
        }
        .padding(10)
    }
}

// TODO: Add preview supporting CoreData
//struct EventRow_Previews: PreviewProvider {
//    static var previews: some View {
//        EventRow()
//    }
//}
