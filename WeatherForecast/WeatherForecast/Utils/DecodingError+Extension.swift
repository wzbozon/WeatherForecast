//
//  DecodingError+Extension.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 22/04/2023.
//

import Foundation

extension DecodingError {
    var message: String {
        var output = ""
        
        switch self {
        case .dataCorrupted(let context):
            output = context.debugDescription
        case .keyNotFound(let key, let context):
            output += String(format: "Key '\(key)' not found: %@", context.debugDescription)
            output += String(format: "codingPath: %@", context.codingPath)
        case .valueNotFound(let value, let context):
            output += String(format: "Value '\(value)' not found: %@", context.debugDescription)
            output += String(format: "codingPath: %@", context.codingPath)
        case .typeMismatch(let type, let context):
            output += String(format: "Type '\(type)' mismatch: %@", context.debugDescription)
            output += String(format: "codingPath: %@", context.codingPath)
        default:
            output = localizedDescription
        }
        
        return output
    }
}
