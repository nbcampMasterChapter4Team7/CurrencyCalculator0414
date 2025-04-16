//
//  MainViewModel.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/14/25.
//

class MainViewModel {
    private let cachedCurrencyRateUseCase: CachedCurrencyRateUseCaseProtocol
    private let favoriteUseCase: FavoriteCurrencyUseCaseProtocol
    private let currencyUseCase: CurrencyUseCaseProtocol

    private var allCurrencyData: [CurrencyItem] = []
    private var currencyData: [CurrencyItem] = [] {
        didSet {
            onCurrencyDataChanged?()
        }
    }

    var onCurrencyDataChanged: (() -> Void)?

    init(currencyUseCase: CurrencyUseCaseProtocol,
         favoriteUseCase: FavoriteCurrencyUseCaseProtocol,
         cachedCurrencyRateUseCase: CachedCurrencyRateUseCaseProtocol) {
        self.currencyUseCase = currencyUseCase
        self.favoriteUseCase = favoriteUseCase
        self.cachedCurrencyRateUseCase = cachedCurrencyRateUseCase
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
            guard let self = self else { return }
            switch result {
            case .success(let rawData):
                let enrichedData = rawData.map { currency in
                    let direction = self.cachedCurrencyRateUseCase.evaluateChange(for: currency.currencyCode, newRate: currency.rate)

                    let item = self.cachedCurrencyRateUseCase.convertToCurrencyItem(
                        currencyCode: currency.currencyCode,
                        rate: currency.rate,
                        country: currency.country,
                        isFavorite: currency.isFavorite,
                        direction: direction
                    )

                    self.cachedCurrencyRateUseCase.updateCache(currencyCode: currency.currencyCode, rate: currency.rate)

                    return item
                }

                self.allCurrencyData = enrichedData
                self.currencyData = self.applyFavoriteAndSort(enrichedData)

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
