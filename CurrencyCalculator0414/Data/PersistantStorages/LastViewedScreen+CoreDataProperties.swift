//
//  LastViewedScreen+CoreDataProperties.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/16/25.
//
//

import Foundation
import CoreData

extension LastViewedScreen {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<LastViewedScreen> {
        return NSFetchRequest<LastViewedScreen>(entityName: "LastViewedScreen")
    }

    @NSManaged public var screenName: String?
    @NSManaged public var currencyCode: String?
    @NSManaged public var country: String?
    @NSManaged public var rate: Double
}

extension LastViewedScreen : Identifiable {

}
