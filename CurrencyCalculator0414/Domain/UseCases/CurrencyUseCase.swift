//
//  CurrencyUseCase.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/14/25.
//

protocol CurrencyUseCaseProtocol {
    func execute(completion: @escaping (Result<[CurrencyItem], Error>) -> Void)
}

class CurrencyUseCase: CurrencyUseCaseProtocol {
    private let repository: CurrencyRepositoryProtocol
    private(set) var currencies: [CurrencyItem] = []

    init(repository: CurrencyRepositoryProtocol) {
        self.repository = repository
    }

    func execute(completion: @escaping (Result<[CurrencyItem], Error>) -> Void) {
        repository.fetchCurrencies(completion: completion)
    }
}
