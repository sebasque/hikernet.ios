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
    
    public var wrappedDuration: Int64 {
        duration
    }
    
    public var wrappedDistance: Double {
        distance
    }
    
    public var wrappedStartTime: Date {
        startTime ?? Date()
    }
    
    public var wrappedEndTime: Date {
        endTime ?? Date()
    }

    public var wrappedCarrier: String {
        carrier ?? "Uknown Carrier"
    }
    
    public var wrappedManufacturer: String {
        manufacturer ?? "Uknown Manufacturer"
    }
    
    public var wrappedOsVersion: String {
        osVersion ?? "Uknown OS Version"
    }
    
    public var featuresArray: [Feature] {
        let set = features as? Set<Feature> ?? []
        return set.sorted {
            $0.wrappedTimestamp < $1.wrappedTimestamp
        }
    }
    
    
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
