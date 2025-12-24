//
//  MoyaProvider.swift
//  HomeHero
//
//  Created by Dion Calim on 2025-12-21.
//

import Moya

extension MoyaProvider {
    func asyncRequest(_ target: Target) async throws -> Response {
        try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)

                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

