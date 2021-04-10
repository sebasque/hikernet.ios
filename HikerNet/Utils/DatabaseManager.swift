
import CoreData

// MARK: Manager for local cache of hike data
struct DatabaseManager {
    static private let managedContext = PersistenceController.shared.container.viewContext
    static private let isoFormatter = ISO8601DateFormatter()
    
    // Retrieve hikes from local storage
    static func getHikes() -> [HikePost] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Hike")
        var hikesToUpload = [HikePost]()
        do {
            let hikes = try managedContext.fetch(fetchRequest) as! [Hike]
            for hike in hikes {
                var newHike = HikePost(
                    duration: Int(hike.wrappedDuration),
                    distance: hike.wrappedDistance,
                    start: isoFormatter.string(from: hike.wrappedStart),
                    end: isoFormatter.string(from: hike.wrappedEnd),
                    carrier: hike.wrappedCarrier,
                    manufacturer: hike.wrappedManufacturer,
                    os: hike.wrappedOs,
                    features: []
                )
                for feature in hike.featuresArray {
                    let newFeature = FeaturePost(
                        timestamp: isoFormatter.string(from: feature.wrappedTimestamp),
                        battery: feature.battery,
                        network: feature.wrappedNetwork,
                        service: feature.wrappedService,
                        connected: feature.wrappedConnected,
                        http: feature.wrappedHttp,
                        lat: feature.wrappedLat,
                        lon: feature.wrappedLon,
                        accuracy: feature.wrappedAccuracy,
                        speed: feature.wrappedSpeed
                    )
                    newHike.features.append(newFeature)
                }
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
