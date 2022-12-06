//
//  StopwatchExerciseTests.swift
//  StopwatchExerciseTests
//
//  Created by Sebastien Bastide on 15/11/2022.
//

import XCTest
import Combine
@testable import StopwatchExercise


final class StopwatchExerciseTests: XCTestCase {
    var timerPublisher: AnyPublisher<Publishers.Autoconnect<Timer.TimerPublisher>.Output, Publishers.Autoconnect<Timer.TimerPublisher>.Failure>!
    var cancellable: AnyCancellable!
    var watch: WatchViewModel!
    
    override func setUp() {
        timerPublisher = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect().eraseToAnyPublisher()
        cancellable = .none
        // watch = WatchViewModel(timerPublisher: timerPublisher)
    }
    
    func test_when_stop_after_5_seconds_should_print_2455() {
        let start: () = watch.start()
        let remainingTime = watch.remainingTime - 5
        let pause: () = watch.pause()
        let time = "24:55"
        
        let promise = expectation(description: "time is 24:55")
        
//        watch.$time.sink { time in
//            XCTAssertEqual(watch.$time, "24:55")
//            promise.fulfill()
//        }.store(in: &cancellable)
//        wait(for: [promise], timeout: 2)
    }
}
