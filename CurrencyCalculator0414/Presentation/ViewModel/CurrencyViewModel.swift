//
//  CurrencyViewModel.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/15/25.
//

class CurrencyViewModel {
    func calculateCurrency(input: String,rate: Double,currencyCode: String) -> String {
        let inputAmount = Double(input)!
        let result = inputAmount * rate
        let formattedResult = String(format: "%.2f", result)
        return "\(inputAmount) USD → \(formattedResult) \(currencyCode)"
    }
}
