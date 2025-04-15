//
//  FavoriteCurrencyRepositoryProtocol.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/15/25.
//

protocol FavoriteCurrencyRepositoryProtocol {
    func getAllData() -> [FavoriteCurrencyItem]
    func createData(favoriteCurrencyItem: FavoriteCurrencyItem)
    func updateData(favoriteCurrencyItem: FavoriteCurrencyItem)
    func deleteData(currencyCode: String)
}
