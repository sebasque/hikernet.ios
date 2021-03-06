
struct FeaturePost: Codable {
    
    var timestamp: String
    var battery: Int16
    var network: String
    var service: Bool
    var connected: Bool
    var lat: Double
    var lon: Double
    var accuracy: Double
    var speed: Double
    
    enum CodingKeys: String, CodingKey {
        case timestamp
        case battery
        case network
        case service
        case connected
        case lat
        case lon
        case accuracy
        case speed
    }
}
