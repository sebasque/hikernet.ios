
import Foundation
import SwiftUI

// MARK: App constants.
struct Constants {
    static private let env = "test"
    static let apiUrl = (env == "prod") ? "https://hikernet.rnoc.gatech.edu" : "https://2f1fe065fa5c.ngrok.io"
    
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
}



