
struct FeatureResponse: Codable, Identifiable {
    
    var id: Int
    var timestamp: String
    var batteryLevel: Int
    var networkType: String
    var serviceState: String
    var isConnected: Int
    var httpConnection: Int
    var lat: Double
    var lon: Double
    var accuracy: Double
    var speed: Double
    var notes: String?
    var hikeId: Int
    var detailedState: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case timestamp
        case batteryLevel = "battery_level"
        case serviceState = "service_state"
        case isConnected = "is_connected"
        case httpConnection = "http_connection"
        case networkType = "network_type"
        case lat
        case lon
        case accuracy
        case speed
        case notes
        case hikeId = "hike_id"
        case detailedState = "detailed_state"
    }
}
