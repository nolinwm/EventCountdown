//
//  DateExtension.swift
//  EventCountdown
//
//  Created by Nolin McFarland on 2/19/22.
//

import Foundation

extension Date {
    static var midnightTomorrow: Date {
        let tomorrow = Date.now.addingTimeInterval(86_400)
        let components = Calendar.current.dateComponents([.year, .month, .day], from: tomorrow)
        let midnightTomorrow = Calendar.current.date(from: components)

        return midnightTomorrow!
    }
    
    static func countdown(_ date: Date) -> DateComponents {
        return Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute, .second],
            from: Date.now,
            to: date
        )
    }
}
