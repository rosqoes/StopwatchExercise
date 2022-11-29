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

    var body: some View {
        VStack(spacing: 30) {
            Text(watch.time).font(.system(size: 80))
            Button(action: { watch.isStarted ? watch.pause() : watch.start() }) {
                Image(systemName: watch.isStarted ? "pause.fill" : "play.fill")
                    .font(.system(size: 60))
                    .animation(nil, value: UUID())
            }
            .foregroundColor(.primary)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(watch: Watch(timerPublisher: Timer.publish(every: 1.0, on: .main, in: .common).autoconnect().eraseToAnyPublisher()))
    }
}
