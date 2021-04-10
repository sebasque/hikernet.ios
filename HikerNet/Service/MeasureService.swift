
import SwiftUI
import CoreData
import CoreLocation
import CoreTelephony
import Network
import UIKit

class MeasureService: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    // Network monitor, database, and location update variables
    let context = PersistenceController.shared.container.viewContext
    let networkMonitor = NWPathMonitor(requiredInterfaceType: .cellular)
    let queue = DispatchQueue(label: "HNNetworkMonitor")
    let locationManager = CLLocationManager()
    let measureInterval = 30
    
    // Measurement variables
    var hike: Hike?
    var currentDate = Date()
    var currentLocation = CLLocation()
    var locationPoints = [CLLocation]()
    var firstLocationRequest = true
    var batteryLevel = 0
    
    static var recording = false
    @Published var testInProgress = false
    @Published var connected = false
    @Published var distance = 0.0
    @Published var startTime = Date()
    
    // HTTP test
    var http = false
    let request: URLRequest = {
        let url = URL(string: "https://www.google.com")
        var r = URLRequest(url: url!)
        r.httpMethod = "GET"
        r.allowsCellularAccess = true
        r.allowsConstrainedNetworkAccess = true
        r.allowsExpensiveNetworkAccess = true
        r.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        r.timeoutInterval = 10
        return r
    }()
    
    static let shared = MeasureService()
    override private init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.allowsBackgroundLocationUpdates = true
        
        UIDevice.current.isBatteryMonitoringEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(batterLevelDidChange), name: UIDevice.batteryLevelDidChangeNotification, object: nil)
        
        networkMonitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.connected = path.status == .satisfied
            }
        }
        networkMonitor.start(queue: DispatchQueue(label: "HNNetworkMonitor"))
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if (MeasureService.recording && !(manager.authorizationStatus == .authorizedAlways)) {
            stopUpdates()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (firstLocationRequest) {
            currentLocation = locations.last!
            currentDate = Date()
            firstLocationRequest = false
            saveFeature()
        } else if ((Int(currentDate.timeIntervalSinceNow.rounded()) * -1) >= measureInterval) {
            currentLocation = locations.last!
            currentDate = Date()
            saveFeature()
        }
        updateDistance(location: currentLocation)
        updateHike()
    }
    
    @objc func batterLevelDidChange() {
        batteryLevel = Int((UIDevice.current.batteryLevel * 100).rounded())
    }
    
    func startUpdates() {
        MeasureService.recording = true
        startHike()
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdates() {
        MeasureService.recording = false
        stopHike()
        locationManager.stopUpdatingLocation()
    }
    
    func startHike() {
        startTime = Date()
        batteryLevel = Int((UIDevice.current.batteryLevel * 100).rounded())
        
        let entity = NSEntityDescription.entity(forEntityName: "Hike", in: context)!
        hike = Hike(entity: entity, insertInto: context)
        hike!.setValue(startTime, forKey: "start")
        hike!.setValue(UserDefaultsManager.getCarrier(), forKey: "carrier")
        hike!.setValue("Apple", forKey: "manufacturer")
        hike!.setValue(UIDevice.current.systemVersion, forKey: "os")
        
        saveContext()
    }
    
    func stopHike() {
        updateHike()
        firstLocationRequest = true
        batteryLevel = 0
        connected = false
        distance = 0.0
        locationPoints.removeAll()
    }
    
    private func updateHike() {
        let endTime = Date()
        let timeElapsed = (endTime.timeIntervalSince1970 - hike!.start!.timeIntervalSince1970).rounded()
        hike!.setValue(Int64(timeElapsed), forKey: "duration")
        hike!.setValue(distance/1000, forKey: "distance")
        hike!.setValue(endTime, forKey: "end")
        saveContext()
    }
    
    func saveFeature() {
        testInProgress = true
        
        let entity = NSEntityDescription.entity(forEntityName: "Feature", in: context)!
        let feature = Feature(entity: entity, insertInto: context)
        
        feature.setValue(Date(), forKey: "timestamp")
        feature.setValue(Int16(batteryLevel), forKey: "battery")
        feature.setValue(getNetworkType(), forKey: "network")
        feature.setValue(getServiceState(), forKey: "service")
        feature.setValue(connected, forKey: "connected")
        feature.setValue(currentLocation.coordinate.latitude, forKey: "lon")
        feature.setValue(currentLocation.coordinate.longitude, forKey: "lat")
        feature.setValue(currentLocation.horizontalAccuracy, forKey: "accuracy")
        feature.setValue(currentLocation.speed, forKey: "speed")
        feature.setValue(hike, forKey: "origin")

        URLSession.shared.dataTask(with: request) { _, response, error in
            DispatchQueue.main.async {
                if let httpResponse = response as? HTTPURLResponse {
                    self.http = httpResponse.statusCode == 200
                    feature.setValue(self.http, forKey: "http")
                    print("HTTP SUCCESS")
                } else {
                    self.http = false
                    feature.setValue(self.http, forKey: "http")
                    print("HTTP FAIL")
                }
                self.testInProgress = false
                self.saveContext()
            }
        }.resume()
    }

    private func updateDistance(location: CLLocation) {
        if (locationPoints.count > 0) {
            distance += location.distance(from: locationPoints.last!)
        }
        locationPoints.append(location)
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

extension MeasureService {
    private func getServiceState() -> Bool {
        let networkInfo = CTTelephonyNetworkInfo()
        let radioTech = networkInfo.serviceCurrentRadioAccessTechnology!
        return radioTech.count > 0
    }
    
    private func getNetworkType() -> String {
        let networkInfo = CTTelephonyNetworkInfo()
        let radioTech = networkInfo.serviceCurrentRadioAccessTechnology!
        if radioTech.count > 0 {
            for (_, val) in radioTech {
                switch(val) {
                case CTRadioAccessTechnologyLTE: return Constants.RadioTech.LTE
                case CTRadioAccessTechnologyGPRS: return Constants.RadioTech.GPRS
                case CTRadioAccessTechnologyCDMA1x: return Constants.RadioTech.CDMA1x
                case CTRadioAccessTechnologyEdge: return Constants.RadioTech.EDGE
                case CTRadioAccessTechnologyWCDMA: return Constants.RadioTech.WCDMA
                case CTRadioAccessTechnologyHSDPA: return Constants.RadioTech.HSDPA
                case CTRadioAccessTechnologyHSUPA: return Constants.RadioTech.HSUPA
                case CTRadioAccessTechnologyCDMAEVDORev0: return Constants.RadioTech.CDMAEVDOREV0
                case CTRadioAccessTechnologyCDMAEVDORevA: return Constants.RadioTech.CDMAEVDOREVA
                case CTRadioAccessTechnologyCDMAEVDORevB: return Constants.RadioTech.CDMAEVDOREVB
                case CTRadioAccessTechnologyeHRPD: return Constants.RadioTech.EHRPD
                case CTRadioAccessTechnologyNRNSA: return Constants.RadioTech.NRNSA
                case CTRadioAccessTechnologyNR: return Constants.RadioTech.NR
                default: return Constants.RadioTech.UNKNOWN
                }
            }
        }
        return "NULL"
    }
}
