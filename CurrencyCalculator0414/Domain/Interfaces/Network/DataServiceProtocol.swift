//
//  DataServiceProtocol.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/14/25.
//

protocol DataServiceProtocol: AnyObject {
    func loadCurrencies(completion: @escaping (Result<[CurrencyItem],Error>) -> Void)
}
