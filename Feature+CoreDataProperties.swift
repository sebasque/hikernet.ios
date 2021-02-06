//
//  Feature+CoreDataProperties.swift
//  HikerNet
//
//  Created by Michael Koohang on 2/5/21.
//
//

import Foundation
import CoreData


extension Feature {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Feature> {
        return NSFetchRequest<Feature>(entityName: "Feature")
    }

    @NSManaged public var accuracy: Double
    @NSManaged public var battery: Int16
    @NSManaged public var connected: Bool
    @NSManaged public var httpConnection: Bool
    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var networkType: String?
    @NSManaged public var inService: Bool
    @NSManaged public var speed: Double
    @NSManaged public var timestamp: Date?
    @NSManaged public var origin: Hike?

}

extension Feature : Identifiable {

}
