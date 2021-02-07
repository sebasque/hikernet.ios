
import CoreData

struct DatabaseManager {
    static private let managedContext = PersistenceController.shared.container.viewContext
    
    // Retrieve hikes from local storage
    static func getHikes() -> [HikePost] {
        let isoFormatter = ISO8601DateFormatter()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Hike")
        var hikesToUpload = [HikePost]()
        do {
            let hikes = try managedContext.fetch(fetchRequest) as! [Hike]
            for hike in hikes {
                var newHike = HikePost(
                    duration: Int(hike.wrappedDuration),
                    distance: hike.wrappedDistance,
                    startTime: isoFormatter.string(from: hike.wrappedStartTime),
                    endTime: isoFormatter.string(from: hike.wrappedEndTime),
                    carrier: hike.wrappedCarrier,
                    manufacturer: hike.wrappedManufacturer,
                    osVersion: hike.wrappedOsVersion,
                    deviceId: UserDefaultsManager.getId(),
                    features: []
                )
                var features = [FeaturePost]()
                for feature in hike.featuresArray {
                    let newFeature = FeaturePost(
                        timestamp: isoFormatter.string(from: feature.wrappedTimestamp),
                        batteryLevel: feature.battery,
                        networkType: feature.wrappedNetworkType,
                        serviceState: feature.wrappedInService ? "IN_SERVICE" : "OUT_OF_SERVICE",
                        isConnected: feature.wrappedConnected,
                        httpConnection: feature.wrappedHttpConnection,
                        lat: feature.wrappedLat,
                        lon: feature.wrappedLon,
                        accuracy: feature.wrappedAccuracy,
                        speed: feature.wrappedSpeed,
                        detailedState: "null"
                    )
                    features.append(newFeature)
                }
                newHike.features = features
                hikesToUpload.append(newHike)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return hikesToUpload
    }
    
    // Clear data from local storage
    static func clearCache() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Hike")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
}
