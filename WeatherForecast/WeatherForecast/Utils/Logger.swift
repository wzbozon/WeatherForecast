//
//  Logger.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 22/04/2023.
//

import Foundation
import OSLog

extension Logger {
    static let `default` = Logger(subsystem: subsystem, category: "")

    private static var subsystem = Bundle.main.bundleIdentifier!
}
