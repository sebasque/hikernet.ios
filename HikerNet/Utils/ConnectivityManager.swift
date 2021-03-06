//
//  ConnectivityManager.swift
//  HikerNet
//
//  Created by Michael Koohang on 3/5/21.
//

import Foundation

struct ConnectivityManager {
    static func calcConnectivity(hikes: [HikeResponse]) -> Int {
        var connectedPercentage = 0
        var featureCount = 0
        for hike in hikes {
            for feature in hike.features {
                featureCount += 1
                if feature.service == 1 {
                    connectedPercentage += 1
                }
            }
        }
        if featureCount > 0 {
            return connectedPercentage / featureCount * 100
        } else {
            return 0
        }
    }
}
