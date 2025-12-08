//
//  Auth.swift
//  HomeHero
//
//  Created by Dion Calim on 2025-12-07.
//

var authToken: String?

func getToken() -> String? {
    return authToken
}

func setToken(token: String) {
    authToken = token
}
