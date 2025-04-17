//
//  CachedCurrencyRateRepository.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/15/25.
//

import CoreData

class CachedCurrencyRateRepository: CachedCurrencyRateRepositoryProtocol {
    private let context = CoreDataManager.shared.context
    
    func fetchRate(for currencyCode: String, on date: Date) -> Double? {
        let request: NSFetchRequest<CachedCurrencyRate> = CachedCurrencyRate.fetchRequest()
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "currencyCode == %@", currencyCode),
            NSPredicate(format: "date >= %@ AND date < %@", startOfDay as NSDate, endOfDay as NSDate)
        ])
        request.fetchLimit = 1
        
        do {
            return try context.fetch(request).first?.rate
        } catch {
            print("[CoreData] Fetch 실패: \(error)")
            return nil
        }
    }
    
    func saveRate(_ rate: Double, for currencyCode: String, on date: Date) {
        let startOfDay = Calendar.current.startOfDay(for: date)
        
        let request: NSFetchRequest<CachedCurrencyRate> = CachedCurrencyRate.fetchRequest()
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "currencyCode == %@", currencyCode),
            NSPredicate(format: "date == %@", startOfDay as NSDate)
        ])
        request.fetchLimit = 1
        
        do {
            if let existing = try context.fetch(request).first {
                if abs(existing.rate - rate) < 0.000001 {
                    return
                }
                existing.rate = rate
            } else {
                let entity = CachedCurrencyRate(context: context)
                entity.currencyCode = currencyCode
                entity.rate = rate
                entity.date = startOfDay
            }
            try context.save()
        } catch {
            print("[CoreData] Save 실패: \(error)")
        }
    }
    
    func compareWithPreviousRate(_ newRate: Double, for currencyCode: String) -> RateChangeDirection {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        guard let yesterday = calendar.date(byAdding: .day, value: -1, to: today),
              let previousRate = fetchRate(for: currencyCode, on: yesterday) else {
            return .same
        }
        if abs(newRate - previousRate) > 0.01 {
            return newRate > previousRate ? .up : .down
        } else {
            return .same
        }
    }
}
