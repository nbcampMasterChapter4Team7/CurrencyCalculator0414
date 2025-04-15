//
//  CachedCurrencyRate+CoreDataProperties.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/15/25.
//
//

import Foundation
import CoreData


extension CachedCurrencyRate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedCurrencyRate> {
        return NSFetchRequest<CachedCurrencyRate>(entityName: "CachedCurrencyRate")
    }

    @NSManaged public var currencyCode: String?
    @NSManaged public var rate: Double
    @NSManaged public var date: Date?
}

extension CachedCurrencyRate : Identifiable {

}
