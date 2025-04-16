//
//  CachedCurrencyRateUseCase.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/15/25.
//

import Foundation

protocol CachedCurrencyRateUseCaseProtocol {
    func evaluateChange(for currencyCode: String, newRate: Double) -> RateChangeDirection
    func updateCache(currencyCode: String, rate: Double)
    func convertToCurrencyItem(currencyCode: String, rate: Double, country: String, isFavorite: Bool, direction: RateChangeDirection) -> CurrencyItem
}

class CachedCurrencyRateUseCase: CachedCurrencyRateUseCaseProtocol {
    
    private let repository: CachedCurrencyRateRepositoryProtocol
    
    init(repository: CachedCurrencyRateRepositoryProtocol) {
        self.repository = repository
    }
    
    func evaluateChange(for currencyCode: String, newRate: Double) -> RateChangeDirection {
        return repository.compareWithPreviousRate(newRate, for: currencyCode)
    }
    
    func updateCache(currencyCode: String, rate: Double) {
        repository.saveRate(rate, for: currencyCode, on: Date())
    }
    
    func convertToCurrencyItem(currencyCode: String, rate: Double, country: String, isFavorite: Bool, direction: RateChangeDirection) -> CurrencyItem {
        return CurrencyItem(
            currencyCode: currencyCode,
            rate: rate,
            country: country,
            isDown: direction,
            isFavorite: isFavorite
        )
    }
}
