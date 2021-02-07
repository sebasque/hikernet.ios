
import Foundation
import SwiftUI
import CoreData

// MARK: Manager for making API requests to the HikerNet server
struct ApiManager {
    static private let API_URL = "\(Constants.apiUrl)/api"
    
    // Get ID from the server
    static func getId(completion: @escaping (String) -> ()) {
        guard let url = URL(string: "\(API_URL)/auth/register") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { data, _, _ in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(IdResponse.self, from: data) {
                    completion(decodedResponse.key)
                    return
                } else {
                    completion("server")
                    return
                }
            } else {
                completion("connection")
                return
            }
        }.resume()
    }
    
    // Get hikes from the server
    static func getHikes(completion: @escaping ([HikeResponse]) -> ()) {
        guard let url = URL(string: "\(API_URL)/hikes") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(UserDefaultsManager.getId(), forHTTPHeaderField: "device-id")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([HikeResponse].self, from: data) {
                    completion(decodedResponse)
                    return
                }
            }
            completion([])
            return
        }.resume()
    }
    
    // Upload hikes to the server
    static func postHikes(completion: @escaping (String) -> ()) {
        guard let url = URL(string: "\(API_URL)/hikes") else {
            return
        }

        let hikesToUpload = DatabaseManager.getHikes()
        if !hikesToUpload.isEmpty {
            let jsonData = try! JSONEncoder().encode(hikesToUpload)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request) { _, response, error in
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        completion("success")
                        return
                    }
                }
                completion("failed")
                return
            }.resume()
        }
    }

}

