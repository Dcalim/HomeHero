//
//  ProfileApi.swift
//  HomeHero
//
//  Created by Dion Calim on 2025-12-21.
//

import Moya
import Foundation
internal import Alamofire

enum ProfileApi {
    case fetchProfile
}

extension ProfileApi: TargetType {
    var baseURL: URL {
        URL(string: "http://localhost:8080/homeHero/api/v1")!
    }

    var path: String {
        switch self {
        case .fetchProfile:
            return "/loadProfile"
        }
    }

    var method: Moya.Method {
        .get
    }

    var task: Task {
        .requestPlain
    }

    var headers: [String: String]? {
        [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(AuthenticationManager.shared.authToken)"
        ]
    }
}

