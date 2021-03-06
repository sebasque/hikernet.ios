//
//  Hike+CoreDataProperties.swift
//  HikerNet
//
//  Created by Michael Koohang on 2/9/21.
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
    @NSManaged public var start: Date?
    @NSManaged public var end: Date?
    @NSManaged public var carrier: String?
    @NSManaged public var manufacturer: String?
    @NSManaged public var os: String?
    @NSManaged public var features: NSSet?
    
    public var wrappedDuration: Int64 {
        duration
    }
    
    public var wrappedDistance: Double {
        distance
    }
    
    public var wrappedStart: Date {
        start ?? Date()
    }
    
    public var wrappedEnd: Date {
        end ?? Date()
    }

    public var wrappedCarrier: String {
        carrier ?? "Uknown Carrier"
    }
    
    public var wrappedManufacturer: String {
        manufacturer ?? "Uknown Manufacturer"
    }
    
    public var wrappedOs: String {
        os ?? "Uknown OS"
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
