//
//  CityCompletionResponseTests.swift
//  WeatherForecast
//
//  Created by Denis Kutlubaev on 12/11/2024.
//

@testable import WeatherForecast
import XCTest

final class CityCompletionResponseTests: XCTestCase {
    func testCityCompletionResponse() throws {
        let json = """
        {
            "predictions": [
                {
                    "place_id": "ChIJA01I-8YV3UYRIpKj6fQF7L4",
                    "description": "Moscow, Russia"
                },
                {
                    "place_id": "ChIJdd4hrwug2EcRmSrV3Vo6llI",
                    "description": "Moscow, ID, USA"
                }
            ]
        }
        """
        let jsonData = json.data(using: .utf8)!
        let response = try JSONDecoder().decode(CityCompletionResponse.self, from: jsonData)
        XCTAssertEqual(response.predictions.count, 2)
        XCTAssertEqual(response.predictions[0].id, "ChIJA01I-8YV3UYRIpKj6fQF7L4")
        XCTAssertEqual(response.predictions[0].description, "Moscow, Russia")
        XCTAssertEqual(response.predictions[1].id, "ChIJdd4hrwug2EcRmSrV3Vo6llI")
        XCTAssertEqual(response.predictions[1].description, "Moscow, ID, USA")
    }
}
