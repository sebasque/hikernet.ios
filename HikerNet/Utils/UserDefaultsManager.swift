
import Foundation

struct UserDefaultsManager {
    static private let defaults = UserDefaults.standard
    static private let CARRIER_KEY = "carrier"
    static private let ID_KEY = "id"
    static private let ONBOARDING_DONE_KEY = "onboarding_done"
    
    static func setCarrier(carrier: String) {
        defaults.setValue(carrier, forKey: CARRIER_KEY)
    }
    
    static func getCarrier() -> String {
        return defaults.string(forKey: CARRIER_KEY) ?? ""
    }
    
    static func setId(id: String) {
        defaults.setValue(id, forKey: ID_KEY)
    }
    
    static func getId() -> String {
        return defaults.string(forKey: ID_KEY) ?? ""
    }
    
    static func setOnboardingDone(done: Bool) {
        defaults.setValue(done, forKey: ONBOARDING_DONE_KEY)
    }
    
    static func getOnboardingDone() -> Bool {
        return defaults.bool(forKey: ONBOARDING_DONE_KEY)
    }
}
