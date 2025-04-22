//
//  LastViewedScreenRepository.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/16/25.
//

import CoreData
import UIKit

class LastViewedScreenRepository: LastViewedScreenRepositoryProtocol {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = CoreDataManager.shared.context) {
        self.context = context
    }
    
    func save(screenName: String, currency: CurrencyItem?) {
        deleteExisting()

        let entity = LastViewedScreen(context: context)
        entity.screenName = screenName

        if let currency = currency {
            entity.currencyCode = currency.currencyCode
            entity.country = currency.country
            entity.rate = currency.rate
        }

        do {
            try context.save()
        } catch {
            print("Save Error: \(error)")
        }
    }

    func get() -> (screenName: String?, currency: CurrencyItem?) {
        let request: NSFetchRequest<LastViewedScreen> = LastViewedScreen.fetchRequest()

        do {
            let results = try context.fetch(request)

            guard let entity = results.first else {
                return (nil, nil)
            }

            var currencyItem: CurrencyItem? = nil

            if let code = entity.currencyCode,
               let country = entity.country {
                currencyItem = CurrencyItem(currencyCode: code, rate: entity.rate, country: country,isDown: .same, isFavorite: false)
            }

            return (entity.screenName, currencyItem)

        } catch {
            print("Fetch Error: \(error)")
            return (nil, nil)
        }
    }

    private func deleteExisting() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = LastViewedScreen.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
        } catch {
            print("Delete Error: \(error)")
        }
    }
}
