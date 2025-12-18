//
//  ApiService.swift
//  HomeHero
//
//  Created by Dion Calim on 2025-12-07.
//

import Foundation


class ApiService {
    static let shared = ApiService()
    private let authManager = AuthenticationManager.shared
    private let baseUrl = "http://localhost:8080/homeHero/api/v1"
    private init() {}
    
    // MARK: - Config Service
    struct Config {
        static func fetchConfig() async throws -> ConfigResponse {
            guard let request = makeRequest(endpoint: "/config", method: "GET") else {
                throw URLError(.badURL)
            }
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(ConfigResponse.self, from: data)
        }
    }
    
    // MARK: - Helper
    private static func makeRequest(endpoint: String, method: String, body: Data? = nil) -> URLRequest? {
        guard let url = URL(string: "\(ApiService.shared.baseUrl)\(endpoint)") else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method
        if let body = body {
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        if let token = ApiService.shared.authManager.authToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
}

