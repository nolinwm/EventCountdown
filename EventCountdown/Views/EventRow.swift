//
//  EventRow.swift
//  EventCountdown
//
//  Created by Nolin McFarland on 2/19/22.
//

import SwiftUI

struct EventRow: View {
    
    let event: Event
    
    var body: some View {
        HStack {
            Image(systemName: "circle.fill")
                .foregroundColor(Color(hex: event.colorAsHex))
            Text(event.name ?? "Event")
                .font(.headline)
            Spacer()
        }
    }
}

// TODO: Add preview supporting CoreData
//struct EventRow_Previews: PreviewProvider {
//    static var previews: some View {
//        EventRow()
//    }
//}