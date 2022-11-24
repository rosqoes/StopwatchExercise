//
//  Watch.swift
//  StopwatchExercise
//
//  Created by Pierre on 24/11/2022.
//

import Foundation
import Combine

class Watch: ObservableObject {
    @Published var isStarted: Bool = false
    @Published var remainingTime: Int = 1500
    @Published var time: String = "25:00"
    
    private var cancellable: AnyCancellable? = .none
    private let timerPublisher = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect().eraseToAnyPublisher()
    
    private func start() {
        isStarted.toggle()
        cancellable = timerPublisher
            .sink { _ in
                self.remainingTime -= 1
                self.time = self.convertIntToStringDate(timeInSecond: self.remainingTime)
                if self.remainingTime == 0 {
                    self.reset()
                }
            }
    }

    private func pause() {
        isStarted.toggle()
        cancellable = .none
    }

    private func reset() {
        time = "25:00"
        remainingTime = 1500
        isStarted = false
        cancellable = .none
    }

    private func convertIntToStringDate(timeInSecond: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:ss"
        let date = Date(timeIntervalSinceReferenceDate: Double(timeInSecond))
        return formatter.string(from: date)
    }
}
