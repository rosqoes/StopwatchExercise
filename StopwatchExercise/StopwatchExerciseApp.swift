//
//  StopwatchExerciseApp.swift
//  StopwatchExercise
//
//  Created by Sebastien Bastide on 15/11/2022.
//

import SwiftUI

@main
struct StopwatchExerciseApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView(watch: WatchViewModel(timerPublisher: Timer.publish(every: 1.0, on: .main, in: .common).autoconnect().eraseToAnyPublisher(), duration: 1500))
        }
    }
}
