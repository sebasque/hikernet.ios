
import Foundation
import SwiftUI
import CoreData

// MARK: Manager for making API requests to the HikerNet server
struct ApiManager {
    static private let API_URL = Constants.apiUrl
    static private let managedContext = PersistenceController.shared.container.viewContext
    
    // Register an ID with the API
    static func getID(completion: @escaping (String) -> ()) {

        guard let url = URL(string: "\(API_URL)/api/auth/register") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(IdResult.self, from: data) {
                    completion(decodedResponse.key)
                    return
                } else {
                    completion("server")
                    return
                }
            } else {
                completion("connection")
                return
            }
        }.resume()
    }
    
    static func uploadHikes(completion: @escaping (String) -> ()) {
        let isoFormatter = ISO8601DateFormatter()
        guard let url = URL(string: "\(API_URL)/api/hikes") else {
            return
        }
//
//        / hikeJSON.put("duration", hike.duration)
//        hikeJSON.put("distance", hike.distance)
//        hikeJSON.put("start_time", hike.startTime)
//        hikeJSON.put("end_time", hike.endTime)
//        hikeJSON.put("carrier", hike.carrier)
//        hikeJSON.put("manufacturer", hike.manufacturer)
//        hikeJSON.put("os_version", hike.osVersion)
//        hikeJSON.put("device_id", hike.deviceId)
//        for (feature in hike.features) {
//            val featureJSON = JSONObject()
//            featureJSON.put("timestamp", feature.timestamp)
//            featureJSON.put("is_connected", feature.isConnected)
//            featureJSON.put("service_state", feature.serviceState)
//            featureJSON.put("detailed_state", feature.detailedState)
//            featureJSON.put("battery_level", feature.batteryLevel)
//            featureJSON.put("http_connection", feature.httpConnection)
//            featureJSON.put("network_type", feature.networkType)
//            featureJSON.put("lat", feature.lat)
//            featureJSON.put("lon", feature.lon)
//            featureJSON.put("accuracy", feature.accuracy)
//            featureJSON.put("speed", feature.speed)
        var finalHikes: [[String:Any]] = []

        let fetchRequest =
            NSFetchRequest<NSFetchRequestResult>(entityName: "Hike")
        do {
            let hikes = try managedContext.fetch(fetchRequest) as! [Hike]
            var features: [[String:Any]] = []
            for hike in hikes {
                var hikeObj: [String : Any] = [:]
                hikeObj["duration"] = hike.wrappedDuration
                hikeObj["distance"] = hike.wrappedDistance
                hikeObj["start_time"] = isoFormatter.string(from: hike.wrappedStartTime)
                hikeObj["end_time"] = isoFormatter.string(from: hike.wrappedEndTime)
                hikeObj["carrier"] = hike.wrappedCarrier
                hikeObj["manufacturer"] = hike.wrappedManufacturer
                hikeObj["os_version"] = hike.wrappedOsVersion
                hikeObj["device_id"] = UserDefaultsManager.getId()
                for feature in hike.featuresArray {
                    var newFeature: [String:Any] = [:]
                    newFeature["timestamp"] = isoFormatter.string(from: feature.wrappedTimestamp)
                    newFeature["is_connected"] = feature.wrappedConnected
                    newFeature["service_state"] = feature.wrappedServiceState
                    newFeature["detailed_state"] = "null"
                    newFeature["battery_level"] = feature.battery
                    newFeature["http_connection"] = feature.wrappedHttpConnection
                    newFeature["network_type"] = feature.networkType
                    newFeature["lat"] = feature.wrappedLat
                    newFeature["lon"] = feature.wrappedLon
                    newFeature["accuracy"] = feature.wrappedAccuracy
                    newFeature["speed"] = feature.wrappedSpeed
                    features.append(newFeature)
                }
                hikeObj["features"] = features
                finalHikes.append(hikeObj)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        let json = try? JSONSerialization.data(withJSONObject: finalHikes, options: .withoutEscapingSlashes)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = json

        URLSession.shared.dataTask(with: request) { data, response, error in
            print(String(data: json!, encoding: .utf8)!)
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(IdResult.self, from: data) {
                    completion(decodedResponse.key)
                    return
                } else {
                    completion("server")
                    return
                }
            } else {
                completion("connection")
                return
            }
        }.resume()
        
    }

}

struct IdResult: Codable {
    var key: String
}

