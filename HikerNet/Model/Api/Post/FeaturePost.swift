
struct FeaturePost: Codable {
    
    var timestamp: String
    var batteryLevel: Int16
    var networkType: String
    var serviceState: String
    var isConnected: Bool
    var httpConnection: Bool
    var lat: Double
    var lon: Double
    var accuracy: Double
    var speed: Double
    var detailedState: String
    
    enum CodingKeys: String, CodingKey {
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
        case detailedState = "detailed_state"
    }
}
