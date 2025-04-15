//
//  CachedCurrencyRateRepository.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/15/25.
//

import CoreData

class CachedCurrencyRateRepository: CachedCurrencyRateRepositoryProtocol {
    
    private let context = CoreDataManager.shared.context
    
    func fetchRate(for currencyCode: String) -> Double? {
        let request: NSFetchRequest<CachedCurrencyRate> = CachedCurrencyRate.fetchRequest()
        request.predicate = NSPredicate(format: "currencyCode == %@", currencyCode)
        request.fetchLimit = 1
        do {
            if let entity = try context.fetch(request).first {
                return entity.rate
            }
        } catch {
            print("[CoreData] Fetch 실패: \(error)")
        }
        return nil
    }
    
    func saveRate(_ rate: Double, for currencyCode: String) {
        let request: NSFetchRequest<CachedCurrencyRate> = CachedCurrencyRate.fetchRequest()
        request.predicate = NSPredicate(format: "currencyCode == %@", currencyCode)
        request.fetchLimit = 1
        do {
            if let existing = try context.fetch(request).first {
                existing.rate = rate
            } else {
                let newEntity = CachedCurrencyRate(context: context)
                newEntity.currencyCode = currencyCode
                newEntity.rate = rate
            }
            try context.save()
        } catch {
            print("[CoreData] Save 실패: \(error)")
        }
    }
    
    func compareWithPreviousRate(_ newRate: Double, for currencyCode: String) -> RateChangeDirection {
        guard let previousRate = fetchRate(for: currencyCode) else {
            return .same
        }
        if abs(newRate-previousRate) > 0.01, newRate > previousRate {
            return .up
        } else if abs(newRate-previousRate) > 0.01, newRate < previousRate {
            return .down
        } else {
            return .same
        }
    }
}
