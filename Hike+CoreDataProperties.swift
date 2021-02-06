//
//  Hike+CoreDataProperties.swift
//  HikerNet
//
//  Created by Michael Koohang on 2/1/21.
//
//

import Foundation
import CoreData


extension Hike {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hike> {
        return NSFetchRequest<Hike>(entityName: "Hike")
    }

    @NSManaged public var duration: Int64
    @NSManaged public var distance: Double
    @NSManaged public var startTime: Date?
    @NSManaged public var endTime: Date?
    @NSManaged public var carrier: String?
    @NSManaged public var manufacturer: String?
    @NSManaged public var osVersion: String?
    @NSManaged public var features: NSSet?

}

// MARK: Generated accessors for features
extension Hike {

    @objc(addFeaturesObject:)
    @NSManaged public func addToFeatures(_ value: Feature)

    @objc(removeFeaturesObject:)
    @NSManaged public func removeFromFeatures(_ value: Feature)

    @objc(addFeatures:)
    @NSManaged public func addToFeatures(_ values: NSSet)

    @objc(removeFeatures:)
    @NSManaged public func removeFromFeatures(_ values: NSSet)

}

extension Hike : Identifiable {

}
