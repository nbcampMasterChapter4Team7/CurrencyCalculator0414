//
//  LastViewedScreenUseCase.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/16/25.
//

protocol LastViewedScreenUseCaseProtocol {
    func save(screenName: String, currency: CurrencyItem?)
    func get() -> (screenName: String?, currency: CurrencyItem?)
}

class LastViewedScreenUseCase: LastViewedScreenUseCaseProtocol {
    private let repository: LastViewedScreenRepositoryProtocol

    init(repository: LastViewedScreenRepositoryProtocol) {
        self.repository = repository
    }

    func save(screenName: String, currency: CurrencyItem? = nil) {
        repository.save(screenName: screenName, currency: currency)
    }

    func get() -> (screenName: String?, currency: CurrencyItem?) {
        repository.get()
    }
}
