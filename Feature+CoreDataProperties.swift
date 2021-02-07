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

    @NSManaged public var timestamp: Date?
    @NSManaged public var battery: Int16
    @NSManaged public var networkType: String?
    @NSManaged public var inService: Bool
    @NSManaged public var connected: Bool
    @NSManaged public var httpConnection: Bool
    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var speed: Double
    @NSManaged public var accuracy: Double
    @NSManaged public var origin: Hike?
    
    var wrappedTimestamp: Date {
        timestamp ?? Date()
    }
    
    var wrappedBattery: Int16 {
        battery
    }
    
    var wrappedNetworkType: String {
        networkType ?? "Uknown Network Type"
    }
    
    var wrappedInService: Bool {
        inService
    }
    
    var wrappedConnected: Bool {
        connected
    }
    
    var wrappedHttpConnection: Bool {
        httpConnection
    }
    
    var wrappedLat: Double {
        lat
    }
    
    var wrappedLon: Double {
        lon
    }
    
    var wrappedSpeed: Double {
        speed
    }
    
    var wrappedAccuracy: Double {
        accuracy
    }

}

extension Feature : Identifiable {

}
