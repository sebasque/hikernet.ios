
struct HikeResponse: Codable, Identifiable {
        
    var id: Int
    var duration: Int
    var distance: Double
    var startTime: String
    var endTime: String
    var carrier: String
    var manufacturer: String
    var osVersion: String
    var deviceId: Int
    var notes: String?
    var features: [FeatureResponse]
    
    enum CodingKeys: String, CodingKey {
        case id
        case duration
        case distance
        case startTime = "start_time"
        case endTime = "end_time"
        case carrier
        case manufacturer
        case osVersion = "os_version"
        case deviceId = "device_id"
        case notes
        case features
    }
}
