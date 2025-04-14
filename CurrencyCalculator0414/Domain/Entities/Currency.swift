//
//  Currency.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/14/25.
//

struct CurrencyResponse: Codable {
    let rates: [String: Double]
}

struct CurrencyItem: Codable {
    let currencyCode: String
    let rate: Double
    let country: String
    let isDown: Bool
    let isFavorite: Bool
}
