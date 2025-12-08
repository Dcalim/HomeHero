//
//  ApiService.swift
//  HomeHero
//
//  Created by Dion Calim on 2025-12-07.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
    case PATCH
}

struct ConfigResponse: Codable {
    let profile: Profile
}

struct Profile: Codable {
    let id: String
    let email: String
    let fullName: String
    let firstName: String
    let lastName: String
    let phoneNumber: String
}

class ApiService {
    static let shared = ApiService()
    private init() {}
    
    private let baseUrl = "http://localhost:8080/homeHero/api/v1"  // Spring Boot
    
    func config() async throws -> ConfigResponse {
        guard let request = makeRequest(endpoint: "/config", method: HTTPMethod.GET.rawValue) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(for: request)
        print(data)
        return try JSONDecoder().decode(ConfigResponse.self, from: data)
    }
    
    func getExampleData() async throws -> [String] {
        guard let url = URL(string: "\(baseUrl)/api/example") else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([String].self, from: data)
    }
    
    func sendPost(name: String) async throws -> String {
        guard let url = URL(string: "\(baseUrl)/api/send") else {
            throw URLError(.badURL)
        }
        
        let body = ["name": name]
        let jsonData = try JSONEncoder().encode(body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return String(decoding: data, as: UTF8.self)
    }
    
    private func makeRequest(endpoint: String, method: String, body: Data? = nil) -> URLRequest? {
        guard let url = URL(string: "\(baseUrl)\(endpoint)") else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = method

        // Add JSON body if present
        if let body = body {
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        // Add Authorization header if token exists
        if let token = authToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        return request
    }

}
