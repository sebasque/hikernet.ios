
import Foundation
import SwiftUI
import CoreData

// MARK: Manager for making API requests to the HikerNet server
struct ApiManager {
    static private let API_URL = "\(Constants.apiUrl)/api"
    
    // Get ID from the server
    static func getId(completion: @escaping (Result<String, ApiError>) -> ()) {
        guard let url = URL(string: "\(API_URL)/auth/register") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { data, _, _ in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(IdResponse.self, from: data) {
                    completion(.success(decodedResponse.id))
                    return
                }
                completion(.failure(.ServerError))
                return
            }
            completion(.failure(.ConnectionError))
            return
        }.resume()
    }
    
    // Get hikes from the server
    static func getHikes(completion: @escaping (Result<[HikeResponse], ApiError>) -> ()) {
        guard let url = URL(string: "\(API_URL)/hikes") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(UserDefaultsManager.getId(), forHTTPHeaderField: "device-id")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([HikeResponse].self, from: data) {
                    completion(.success(decodedResponse))
                    return
                }
                completion(.failure(.ServerError))
                return
            }
            completion(.failure(.ConnectionError))
            return
        }.resume()
    }
    
    // Upload hikes to the server
    static func postHikes(completion: @escaping (Result<ApiMessage, ApiError>) -> ()) {
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
            request.setValue(UserDefaultsManager.getId(), forHTTPHeaderField: "device-id")

            URLSession.shared.dataTask(with: request) { _, response, error in
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        completion(.success(.Success))
                        return
                    }
                    completion(.failure(.RequestError))
                    return
                }
                completion(.failure(.ConnectionError))
                return
            }.resume()
        } else {
            completion(.success(.Empty))
        }
    }
}

enum ApiError: Error {
    case RequestError
    case ServerError
    case ConnectionError
}

enum ApiMessage {
    case Success
    case Empty
}

