//
//  CurrencyRepository.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/14/25.
//

class CurrencyRepository: CurrencyRepositoryProtocol {
    private let dataService: DataServiceProtocol

    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
    }

    func fetchCurrencies(completion: @escaping (Result<[CurrencyItem], Error>) -> Void) {
        dataService.loadCurrencies(completion: completion)
    }
}
