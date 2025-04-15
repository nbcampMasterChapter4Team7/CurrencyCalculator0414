//
//  FavoriteCurrency+CoreDataProperties.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/15/25.
//
//

import Foundation
import CoreData


extension FavoriteCurrency {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteCurrency> {
        return NSFetchRequest<FavoriteCurrency>(entityName: "FavoriteCurrency")
    }

    @NSManaged public var currencyCode: String?
    @NSManaged public var isFavorite: Bool

}

extension FavoriteCurrency : Identifiable {

}
