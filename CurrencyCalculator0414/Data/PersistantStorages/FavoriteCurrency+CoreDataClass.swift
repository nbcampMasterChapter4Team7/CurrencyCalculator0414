//
//  FavoriteCurrency+CoreDataClass.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/15/25.
//
//

import Foundation
import CoreData

@objc(FavoriteCurrency)
public class FavoriteCurrency: NSManagedObject {
    public static let className = "FavoriteCurrency"
    public enum Key {
        static let currencyCode = "currencyCode"
        static let isFavorite = "isFavorite"
    }
}
