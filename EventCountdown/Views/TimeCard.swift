//
//  TimeCard.swift
//  EventCountdown
//
//  Created by Nolin McFarland on 2/19/22.
//

import SwiftUI

struct TimeCard: View {
    
    var color: Color
    var label: String
    var value: Int
    
    var delay: Double
    @State private var animate = false
    
    // Remove the plural s from label if value is 1
    var properLabel: String {
        var str = label
        if value == 1 {
            str.removeLast()
        }
        return str
    }
    
    var body: some View {
        ZStack {
            Circle()
                .opacity(0)
            VStack(alignment: .center) {
                Text("\(max(0, value))")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Text(properLabel)
                    .font(.title2)
            }
            .foregroundColor(.white)
        }
        .padding()
        .aspectRatio(1, contentMode: .fit)
        .background(
            RoundedRectangle(cornerRadius: 40)
                .foregroundColor(value > 0 ? color : .gray)
                .shadow(color: .black.opacity(value > 0 ? 0.125 : 0.0625), radius: 10, x: 0, y: 15)
                .scaleEffect(value > 0 ? 1 : 0.9)
                .animation(.spring(response: 0.25, dampingFraction: 0.65, blendDuration: 1), value: value)
        )
        .scaleEffect(animate ? 1 : 0)
        .opacity(animate ? 1 : 0)
        .animation(.spring(response: 0.25, dampingFraction: 0.65, blendDuration: 1).delay(delay), value: animate)
        .onAppear {
            animate = true
        }
    }
}

struct TimeCard_Previews: PreviewProvider {
    static var previews: some View {
        TimeCard(color: .blue, label: "Minutes", value: 20, delay: 0)
    }
}
