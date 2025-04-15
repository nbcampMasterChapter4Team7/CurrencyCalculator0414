//
//  CachedCurrencyRate+CoreDataClass.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/15/25.
//
//

import Foundation
import CoreData

@objc(CachedCurrencyRate)
public class CachedCurrencyRate: NSManagedObject {
    public static let className = "CachedCurrencyRate"
    public enum Key {
        static let currencyCode = "currencyCode"
        static let rate = "rate"
    }
}
