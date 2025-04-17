//
//  CurrencyViewModel.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/15/25.
//

class CurrencyViewModel {
    private let lastViewedScreenUseCase: LastViewedScreenUseCaseProtocol

    init(lastViewedScreenUseCase: LastViewedScreenUseCaseProtocol) {
        self.lastViewedScreenUseCase = lastViewedScreenUseCase
    }
    
    func recordLastVisited(with currency: CurrencyItem) {
        lastViewedScreenUseCase.save(screenName: "CurrencyCalculatePage", currency: currency)
    }
    
    func calculateCurrency(input: Double,rate: Double,currencyCode: String) -> String {
        let inputAmount = input
        let result = inputAmount * rate
        let formattedResult = String(format: "%.2f", result)
        return "\(inputAmount) USD → \(formattedResult) \(currencyCode)"
    }
}
