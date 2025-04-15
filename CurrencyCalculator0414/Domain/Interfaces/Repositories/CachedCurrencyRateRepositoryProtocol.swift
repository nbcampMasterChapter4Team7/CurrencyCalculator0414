//
//  CachedCurrencyRateRepositoryProtocol.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/15/25.
//

protocol CachedCurrencyRateRepositoryProtocol {
    func fetchRate(for currencyCode: String) -> Double?
    func saveRate(_ rate: Double, for currencyCode: String)
    func compareWithPreviousRate(_ newRate: Double, for currencyCode: String) -> RateChangeDirection
}
