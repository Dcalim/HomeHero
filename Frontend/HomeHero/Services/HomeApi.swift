//
//  HomeApi.swift
//  HomeHero
//
//  Created by Dion Calim on 2026-03-30.
//

import Moya
import Foundation
internal import Alamofire

enum HomeApi {
    case fetchHomes
}

extension HomeApi: TargetType {
    var baseURL: URL {
        URL(string: "http://localhost:8080/homeHero/api/v1")!
    }

    var path: String {
        switch self {
        case .fetchHomes:
            return "/loadHomes"
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
