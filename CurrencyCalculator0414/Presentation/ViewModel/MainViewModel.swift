//
//  MainViewModel.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/14/25.
//

class MainViewModel {
    private var currencyUseCase: CurrencyUseCase
    
    private var allCurrencyData: [CurrencyItem] = []
    private var currencyData: [CurrencyItem] = [] {
        didSet {
            onCurrencyDataChanged?()
        }
    }
    
    var onCurrencyDataChanged: (() -> Void)?
    
    init (currencyUseCase: CurrencyUseCase) {
        self.currencyUseCase = currencyUseCase
        fetchCurrencyData()
    }
    
    private func fetchCurrencyData() {
        currencyUseCase.execute { [weak self] result in
            switch result {
            case .success(let currencyData):
                self?.allCurrencyData = currencyData
                self?.currencyData = currencyData
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func getCurrencyData() -> [CurrencyItem] {
        return currencyData
    }
    
    func searchCurrency(_ keyword: String) {
        guard !keyword.isEmpty else {
            currencyData = allCurrencyData
            return
        }
        let lowercasedKeyword = keyword.lowercased()
        currencyData = allCurrencyData.filter {
            $0.currencyCode.lowercased().contains(lowercasedKeyword) ||
                    $0.country.lowercased().contains(lowercasedKeyword)
        }
    }
}
