//
//  MainViewModel.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/14/25.
//

class MainViewModel {
    private let favoriteUseCase: FavoriteCurrencyUseCaseProtocol
    private let currencyUseCase: CurrencyUseCaseProtocol

    private var allCurrencyData: [CurrencyItem] = []
    private var currencyData: [CurrencyItem] = [] {
        didSet {
            onCurrencyDataChanged?()
        }
    }

    var onCurrencyDataChanged: (() -> Void)?

    init(currencyUseCase: CurrencyUseCaseProtocol, favoriteUseCase: FavoriteCurrencyUseCaseProtocol) {
        self.currencyUseCase = currencyUseCase
        self.favoriteUseCase = favoriteUseCase
        fetchCurrencyData()
    }

    private func applyFavoriteAndSort(_ data: [CurrencyItem]) -> [CurrencyItem] {
        let favoriteCodes = Set(favoriteUseCase.getAllFavorites().map { $0.currencyCode })

        let updated = data.map { item -> CurrencyItem in
            var copy = item
            copy.isFavorite = favoriteCodes.contains(item.currencyCode)
            return copy
        }

        return updated.sorted {
            if $0.isFavorite == $1.isFavorite {
                return $0.currencyCode < $1.currencyCode
            } else {
                return $0.isFavorite && !$1.isFavorite
            }
        }
    }

    private func fetchCurrencyData() {
        currencyUseCase.execute { [weak self] result in
            switch result {
            case .success(let data):
                guard let self = self else { return }
                self.allCurrencyData = data
                self.currencyData = self.applyFavoriteAndSort(data)
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
            currencyData = applyFavoriteAndSort(allCurrencyData)
            return
        }

        let lowercasedKeyword = keyword.lowercased()
        let filtered = allCurrencyData.filter {
            $0.currencyCode.lowercased().contains(lowercasedKeyword) ||
            $0.country.lowercased().contains(lowercasedKeyword)
        }

        currencyData = applyFavoriteAndSort(filtered)
    }

    func toggleFavorite(for currencyCode: String) {
        favoriteUseCase.toggleFavorite(code: currencyCode)
        currencyData = applyFavoriteAndSort(currencyData)
    }
}
