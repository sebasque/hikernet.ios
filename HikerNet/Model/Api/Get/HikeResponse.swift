
struct HikeResponse: Codable, Identifiable {
    var id: Int
    var duration: Int
    var distance: Double
    var start: String
    var end: String
    var carrier: String
    var manufacturer: String
    var os: String
    var features: [FeatureResponse]
    
    enum CodingKeys: String, CodingKey {
        case id
        case duration
        case distance
        case start
        case end
        case carrier
        case manufacturer
        case os
        case features
    }
}
