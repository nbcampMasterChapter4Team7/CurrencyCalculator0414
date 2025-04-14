//
//  CurrencyRepositoryProtocol.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/14/25.
//

protocol CurrencyRepositoryProtocol {
    func fetchCurrencies(completion: @escaping (Result<[CurrencyItem], Error>) -> Void)
}
