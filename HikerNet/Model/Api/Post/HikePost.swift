
struct HikePost: Codable {
        
    var duration: Int
    var distance: Double
    var startTime: String
    var endTime: String
    var carrier: String
    var manufacturer: String
    var osVersion: String
    var deviceId: String
    var features: [FeaturePost]
    
    enum CodingKeys: String, CodingKey {
        case duration
        case distance
        case startTime = "start_time"
        case endTime = "end_time"
        case carrier
        case manufacturer
        case osVersion = "os_version"
        case deviceId = "device_id"
        case features
    }
}
