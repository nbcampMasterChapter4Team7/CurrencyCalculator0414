//
//  FavoriteCurrencyUseCase.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/15/25.
//

protocol FavoriteCurrencyUseCaseProtocol {
    func toggleFavorite(code: String)
    func isFavorite(code: String) -> Bool
    func getAllFavorites() -> [FavoriteCurrencyItem]
}

class FavoriteCurrencyUseCase: FavoriteCurrencyUseCaseProtocol {
    
    private let repository: FavoriteCurrencyRepositoryProtocol
    
    init(repository: FavoriteCurrencyRepositoryProtocol) {
        self.repository = repository
    }
    
    func toggleFavorite(code: String) {
        if repository.getAllData().contains(where: { $0.currencyCode == code }) {
            repository.deleteData(currencyCode: code)
        } else {
            repository.createData(favoriteCurrencyItem: FavoriteCurrencyItem(currencyCode: code, isFavorite: true))
        }
    }
    
    func isFavorite(code: String) -> Bool {
        return repository.getAllData().contains(where: { $0.currencyCode == code })
    }
    
    func getAllFavorites() -> [FavoriteCurrencyItem] {
        return repository.getAllData()
    }
}
