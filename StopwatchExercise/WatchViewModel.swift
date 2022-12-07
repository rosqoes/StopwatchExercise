//
//  Watch.swift
//  StopwatchExercise
//
//  Created by Pierre on 24/11/2022.
//

import Foundation
import Combine

class WatchViewModel: ObservableObject {
    @Published var isStarted: Bool = false
    @Published var remainingTime: Int
    @Published var time: String = "25:00"
    
    private var timerPublisher = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect().eraseToAnyPublisher()
    private var cancellable: AnyCancellable? = .none
    private let initialTime: Int
    
    init(timerPublisher: AnyPublisher<Date, Never>, duration: Int) {
        self.timerPublisher = timerPublisher
        self.remainingTime = duration
        self.initialTime = duration
    }
    
    func start() {
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

    func pause() {
        isStarted.toggle()
        cancellable = .none
    }

    private func reset() {
        time = convertIntToStringDate(timeInSecond: initialTime)
        remainingTime = initialTime
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
