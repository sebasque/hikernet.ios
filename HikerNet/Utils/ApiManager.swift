
import Foundation
import SwiftUI

// MARK: Manager for making API requests to the HikerNet server
struct ApiManager {
    static private let API_URL = Constants.apiUrl
    
    // Register an ID with the API
    static func getID(completion: @escaping (String) -> ()) {

        guard let url = URL(string: "\(API_URL)/api/auth/register") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(IdResult.self, from: data) {
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

}

struct IdResult: Codable {
    var key: String
}

