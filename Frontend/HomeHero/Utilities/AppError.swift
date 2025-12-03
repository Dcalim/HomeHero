//
//  AppError.swift
//  HomeHero
//
//  Created by Antonio Conopio on 2025-12-02.
//

import Foundation

func ErrorString(_ message: String) -> Error {
    return NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
}
