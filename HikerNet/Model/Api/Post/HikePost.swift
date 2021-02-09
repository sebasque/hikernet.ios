
struct HikePost: Codable {
        
    var duration: Int
    var distance: Double
    var start: String
    var end: String
    var carrier: String
    var manufacturer: String
    var os: String
    var deviceId: String
    var features: [FeaturePost]
    
    enum CodingKeys: String, CodingKey {
        case duration
        case distance
        case start
        case end
        case carrier
        case manufacturer
        case os
        case deviceId = "device_id"
        case features
    }
}
