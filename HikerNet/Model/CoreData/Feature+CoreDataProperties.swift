//
//  Feature+CoreDataProperties.swift
//  HikerNet
//
//  Created by Michael Koohang on 2/9/21.
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
    @NSManaged public var service: Bool
    @NSManaged public var connected: Bool
    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var network: String?
    @NSManaged public var speed: Double
    @NSManaged public var timestamp: Date?
    @NSManaged public var origin: Hike?
    
    var wrappedTimestamp: Date {
        timestamp ?? Date()
    }
    
    var wrappedBattery: Int16 {
        battery
    }
    
    var wrappedNetwork: String {
        network ?? "Uknown Network"
    }
    
    var wrappedService: Bool {
        service
    }
    
    var wrappedConnected: Bool {
        connected
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
