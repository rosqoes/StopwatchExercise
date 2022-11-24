//
//  ContentView.swift
//  StopwatchExercise
//
//  Created by Sebastien Bastide on 15/11/2022.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var watch: Watch
    
    @State private var time: String = "25:00"
    @State private var remainingTime: Int = 1500
    @State private var isStarted: Bool = false
    @State private var cancellable: AnyCancellable? = .none

    private let timerPublisher = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect().eraseToAnyPublisher()

    var body: some View {
        VStack(spacing: 30) {
            Text(time).font(.system(size: 80))
            Button(action: { isStarted ? pause() : start() }) {
                Image(systemName: isStarted ? "pause.fill" : "play.fill")
                    .font(.system(size: 60))
                    .animation(nil, value: UUID())
            }
            .foregroundColor(.primary)
        }
    }

    private func start() {
        isStarted.toggle()
        cancellable = timerPublisher
            .sink { _ in
                remainingTime -= 1
                time = convertIntToStringDate(timeInSecond: remainingTime)
                if remainingTime == 0 {
                    reset()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(watch: Watch())
    }
}
