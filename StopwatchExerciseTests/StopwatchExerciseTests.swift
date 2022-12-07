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
    
    func test_init_startWithCorrectValue() {
        let (sut, _) = makeSUT()
        
        XCTAssertEqual(sut.remainingTime, 1500)
        XCTAssertEqual(sut.isStarted, false)
    }
    
    func test_startWatchAndWait30seconds() {
        let (sut, publisher) = makeSUT()
        
        sut.start()
        (1 ... 29).forEach { _ in publisher.sendValue() }
        
        XCTAssertEqual(sut.time, "24:30")
        XCTAssertEqual(sut.isStarted, true)
    }
    
    func test_pauseWatchAfter5seconds() {
        let (sut, publisher) = makeSUT()
        
        sut.start()
        (1 ... 4).forEach { _ in publisher.sendValue() }
        sut.pause()
        XCTAssertEqual(sut.time, "24:55")
        XCTAssertEqual(sut.isStarted, false)
    }
    
    func test_startWatchAndWait25MinutesToReset() {
        let (sut, publisher) = makeSUT()
        
        sut.start()
        // when remainingTime == 0 reset() is used
        (1 ... 1499).forEach { _ in publisher.sendValue() }
        XCTAssertEqual(sut.time, "25:00")
        XCTAssertEqual(sut.isStarted, false)
    }
    
    private func makeSUT(duration: Int = 1500) -> (sut: WatchViewModel, publisher: PublisherStub) {
        let publisher = PublisherStub()
        let sut = WatchViewModel(timerPublisher: publisher.valuePublisher, duration: duration)
        return (sut, publisher)
    }
    
    private class PublisherStub {
        private let valueSubject = CurrentValueSubject<Date, Never>(.now)
        
        var valuePublisher: AnyPublisher<Date, Never> {
            valueSubject.eraseToAnyPublisher()
        }
        
        func sendValue() {
            valueSubject.send(.now)
        }
    }
}
