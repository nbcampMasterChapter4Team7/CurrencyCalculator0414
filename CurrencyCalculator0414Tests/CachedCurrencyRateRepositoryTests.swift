//
//  CachedCurrencyRateRepositoryTests.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/17/25.
//

import XCTest
import CoreData
@testable import CurrencyCalculator0414

final class CachedCurrencyRateRepositoryTests: XCTestCase {
    var repository: CachedCurrencyRateRepository!
    var container: NSPersistentContainer!

    override func setUp() {
        super.setUp()
        container = NSPersistentContainer(name: "CurrencyCalculator0414")

        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType 
        container.persistentStoreDescriptions = [description]

        let exp = expectation(description: "Load Persistent Store")
        container.loadPersistentStores { _, error in
            XCTAssertNil(error)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)

        repository = CachedCurrencyRateRepository(context: container.viewContext)
    }

    override func tearDown() {
        repository = nil
        container = nil
        super.tearDown()
    }

    func testSaveAndFetchRate() {
        let currency = "JPY"
        let rate = 142.0
        let date = Calendar.current.startOfDay(for: Date())

        repository.saveRate(rate, for: currency, on: date)
        let fetched = repository.fetchRate(for: currency, on: date)

        XCTAssertEqual(fetched, rate)
    }
    
    func testSaveSameRateTwice_shouldNotOverwrite() {
        let currency = "JPY"
        let today = Calendar.current.startOfDay(for: Date())
        
        repository.saveRate(142.0, for: currency, on: today)
        
        repository.saveRate(142.0, for: currency, on: today)

        let fetched = repository.fetchRate(for: currency, on: today)

        XCTAssertEqual(fetched, 142.0)
    }
    
    func testSaveDifferentRate_shouldOverwrite() {
        let currency = "JPY"
        let today = Calendar.current.startOfDay(for: Date())
        
        repository.saveRate(142.0, for: currency, on: today)
        repository.saveRate(143.0, for: currency, on: today)

        let fetched = repository.fetchRate(for: currency, on: today)

        XCTAssertEqual(fetched, 143.0)
    }

    func testCompareWithPreviousRate_up() {
        let currency = "EUR"
        let today = Calendar.current.startOfDay(for: Date())
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!

        repository.saveRate(0.87, for: currency, on: yesterday)

        let result = repository.compareWithPreviousRate(0.88, for: currency)
        XCTAssertEqual(result, .up)
    }

    func testCompareWithPreviousRate_down() {
        let currency = "EUR"
        let today = Calendar.current.startOfDay(for: Date())
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!

        repository.saveRate(0.89, for: currency, on: yesterday)

        let result = repository.compareWithPreviousRate(0.88, for: currency)
        XCTAssertEqual(result, .down)
    }

    func testCompareWithPreviousRate_same_when_no_yesterday_data() {
        let result = repository.compareWithPreviousRate(1.0, for: "USD")
        XCTAssertEqual(result, .same)
    }
}
