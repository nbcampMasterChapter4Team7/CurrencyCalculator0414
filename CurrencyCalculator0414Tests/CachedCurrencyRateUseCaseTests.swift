//
//  CachedCurrencyRateUseCaseTests.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/17/25.
//

import XCTest
@testable import CurrencyCalculator0414

final class CachedCurrencyRateUseCaseTests: XCTestCase {

    class MockRepository: CachedCurrencyRateRepositoryProtocol {
        var shouldReturnExistingRate: Double?
        var saveCalled = false
        var savedRate: Double?

        func fetchRate(for currencyCode: String, on date: Date) -> Double? {
            return shouldReturnExistingRate
        }

        func saveRate(_ rate: Double, for currencyCode: String, on date: Date) {
            saveCalled = true
            savedRate = rate
        }

        func compareWithPreviousRate(_ newRate: Double, for currencyCode: String) -> RateChangeDirection {
            return .same
        }
    }

    func testUpdateCache_sameRate_shouldNotSave() {
        // Given
        let mock = MockRepository()
        mock.shouldReturnExistingRate = 140.000000 

        let useCase = CachedCurrencyRateUseCase(repository: mock)

        // When
        useCase.updateCache(currencyCode: "JPY", rate: 140.0)

        // Then
        XCTAssertFalse(mock.saveCalled, "같은 rate일 때는 저장이 되면 안 됨")
    }

    func testUpdateCache_differentRate_shouldSave() {
        // Given
        let mock = MockRepository()
        mock.shouldReturnExistingRate = 139.5

        let useCase = CachedCurrencyRateUseCase(repository: mock)

        // When
        useCase.updateCache(currencyCode: "JPY", rate: 140.0)

        // Then
        XCTAssertTrue(mock.saveCalled, "다른 rate일 때는 저장이 되어야 함")
        XCTAssertEqual(mock.savedRate, 140.0)
    }
}
