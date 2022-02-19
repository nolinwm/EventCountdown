//
//  RefreshTimer.swift
//  EventCountdown
//
//  Created by Nolin McFarland on 2/19/22.
//

import Foundation
import Combine

class RefreshTimer {
    let currentTimePublisher = Timer.TimerPublisher(interval: 1.0, runLoop: .main, mode: .default)
    let cancellable: AnyCancellable?
    
    init() {
        self.cancellable = currentTimePublisher.connect() as? AnyCancellable
    }
    
    deinit {
        self.cancellable?.cancel()
    }
}
