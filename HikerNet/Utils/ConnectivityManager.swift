
// MARK: Manager for calculating connectivity
struct ConnectivityManager {
    
    // Calculate connectivity for a list of hikes
    static func calcConnectivity(hikes: [HikeResponse]) -> Int {
        var connectedPercentage = 0.0
        var featureCount = 0.0
        for hike in hikes {
            for feature in hike.features {
                featureCount += 1
                if feature.http == 1 {
                    connectedPercentage += 1
                }
            }
        }
        return round(part: connectedPercentage, whole: featureCount)
    }
    
    // Calculate connectivity for a single hike
    static func calcConnectivity(hike: HikeResponse) -> Int {
        var connectedPercentage = 0.0
        var featureCount = 0.0
        for feature in hike.features {
            featureCount += 1
            if feature.http == 1 {
                connectedPercentage += 1
            }
        }
        return round(part: connectedPercentage, whole: featureCount)
    }
    
    private static func round(part: Double, whole: Double) -> Int {
        var result = part / whole * 100
        result.round(.toNearestOrAwayFromZero)
        return Int(result)
    }
}
