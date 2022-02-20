//
//  ContentView.swift
//  EventCountdown
//
//  Created by Nolin McFarland on 2/19/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            EventList()
                .navigationTitle("Events")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
