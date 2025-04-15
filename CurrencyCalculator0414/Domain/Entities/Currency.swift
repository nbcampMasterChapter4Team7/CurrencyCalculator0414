//
//  Currency.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/14/25.
//

struct CurrencyResponse: Codable {
    let rates: [String: Double]
}

enum RateChangeDirection: String, Codable {
    case up, down, same
}

struct CurrencyItem: Codable {
    let currencyCode: String
    let rate: Double
    let country: String
    var isDown: RateChangeDirection
    var isFavorite: Bool
}

struct FavoriteCurrencyItem {
    let currencyCode: String
    let isFavorite: Bool
}
