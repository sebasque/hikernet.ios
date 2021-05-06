
struct FeatureResponse: Codable, Identifiable {
    var id: Int
    var timestamp: String
    var battery: Int
    var network: String
    var service: Int
    var connected: Int
    var http: Int
    var lat: Double
    var lon: Double
    var accuracy: Double
    var speed: Double
    var hikeId: Int

    enum CodingKeys: String, CodingKey {
        case id
        case timestamp
        case battery
        case network
        case service
        case connected
        case http
        case lat
        case lon
        case accuracy
        case speed
        case hikeId = "hike_id"
    }
}
