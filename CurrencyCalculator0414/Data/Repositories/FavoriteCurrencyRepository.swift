//
//  FavoriteCurrencyRepository.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/15/25.
//

import CoreData

class FavoriteCurrencyRepository: FavoriteCurrencyRepositoryProtocol {
    
    private let context = CoreDataManager.shared.context
    
    func getAllData() -> [FavoriteCurrencyItem] {
        let request: NSFetchRequest<FavoriteCurrency> = FavoriteCurrency.fetchRequest()
        
        do {
            let results = try context.fetch(request)
            return results.map {
                FavoriteCurrencyItem(
                    currencyCode: $0.currencyCode ?? "",
                    isFavorite: $0.isFavorite
                )
            }
        } catch {
            print("[CoreData] Fetch 실패: \(error)")
            return []
        }
    }
    
    func createData(favoriteCurrencyItem: FavoriteCurrencyItem) {
        let entity = FavoriteCurrency(context: context)
        entity.currencyCode = favoriteCurrencyItem.currencyCode
        entity.isFavorite = favoriteCurrencyItem.isFavorite
        saveContext()
    }
    
    func updateData(favoriteCurrencyItem: FavoriteCurrencyItem) {
        let request: NSFetchRequest<FavoriteCurrency> = FavoriteCurrency.fetchRequest()
        request.predicate = NSPredicate(format: "currencyCode == %@", favoriteCurrencyItem.currencyCode)
        
        do {
            if let existing = try context.fetch(request).first {
                existing.isFavorite = favoriteCurrencyItem.isFavorite
                saveContext()
            }
        } catch {
            print("[CoreData] Update 실패: \(error)")
        }
    }
    
    func deleteData(currencyCode: String) {
        let request: NSFetchRequest<FavoriteCurrency> = FavoriteCurrency.fetchRequest()
        request.predicate = NSPredicate(format: "currencyCode == %@", currencyCode)
        
        do {
            let results = try context.fetch(request)
            results.forEach { context.delete($0) }
            saveContext()
        } catch {
            print("[CoreData] Delete 실패: \(error)")
        }
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("[CoreData] Save 실패: \(error)")
        }
    }
}
