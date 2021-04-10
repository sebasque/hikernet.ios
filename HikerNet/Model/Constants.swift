
import Foundation
import SwiftUI

// MARK: App constants.
struct Constants {
    static private let env = "prod"
    static let apiUrl = (env == "prod") ? "https://hikernet.rnoc.gatech.edu" : "https://c715826e8885.ngrok.io"
    
    struct Fonts {
        static let bold = "WorkSans-Bold"
        static let italic = "WorkSans-Italic"
        static let light = "WorkSans-Light"
        static let medium = "WorkSans-Medium"
        static let regular = "WorkSans-Regular"
        static let semibold = "WorkSans-Semibold"
    }
    
    struct Colors {
        static let green = Color(red: 0.52, green: 0.78, blue: 0.55)
    }
    
    struct RadioTech {
        static let LTE = "LTE"
        static let GPRS = "GPRS"
        static let CDMA1x = "1xRTT"
        static let EDGE = "EDGE"
        static let WCDMA = "WCDMA"
        static let HSDPA = "HSDPA"
        static let HSUPA = "HSUPA"
        static let CDMAEVDOREV0 = "EVDO_REV_0"
        static let CDMAEVDOREVA = "EVDO_REV_A"
        static let CDMAEVDOREVB = "EVDO_REV_B"
        static let EHRPD = "EHRPD"
        static let NRNSA = "NEW_RADIO_5G_NON_STANDALONE"
        static let NR = "NEW_RADIO_5G"
        static let UNKNOWN = "UNKNOWN"
    }
}



