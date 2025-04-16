//
//  CachedCurrencyRateRepositoryProtocol.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/15/25.
//

import Foundation

protocol CachedCurrencyRateRepositoryProtocol {
    func fetchRate(for currencyCode: String, on date: Date) -> Double?
    func saveRate(_ rate: Double, for currencyCode: String, on date: Date)
    func compareWithPreviousRate(_ newRate: Double, for currencyCode: String) -> RateChangeDirection
}
