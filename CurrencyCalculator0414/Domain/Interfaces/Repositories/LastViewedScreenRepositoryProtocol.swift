//
//  LastViewedScreenRepositoryProtocol.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/16/25.
//

protocol LastViewedScreenRepositoryProtocol {
    func save(screenName: String, currency: CurrencyItem?)
    func get() -> (screenName: String?, currency: CurrencyItem?)
}
