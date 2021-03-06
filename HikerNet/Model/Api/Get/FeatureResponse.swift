
struct FeatureResponse: Codable, Identifiable {
    
    var id: Int
    var timestamp: String
    var battery: Int
    var network: String
    var service: Int
    var connected: Int
    var lat: Double
    var lon: Double
    var accuracy: Double
    var speed: Double
    var notes: String?
    var hikeId: Int

    enum CodingKeys: String, CodingKey {
        case id
        case timestamp
        case battery
        case network
        case service
        case connected
        case lat
        case lon
        case accuracy
        case speed
        case notes
        case hikeId = "hike_id"
    }
}
