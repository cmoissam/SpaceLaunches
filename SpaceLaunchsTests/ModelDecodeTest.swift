//
//  ModelDecodeTest.swift
//  SpaceLaunchsTests
//
//  Created by Issam Lanouari on 30/01/2021.
//

import XCTest
@testable import SpaceLaunchs

class ModelDecodeTest: XCTestCase {

    func getJsonData(from resource: String) -> Data {
        guard let pathString = Bundle(for: type(of: self)).url(forResource: resource, withExtension: "json") else {
            fatalError("ressources not found")
        }
        guard let jsonData = try? Data(contentsOf: pathString) else {
            fatalError("Unable to convert UnitTestData.json to String")
        }
        return jsonData
    }
    
    func test_decode_Launchs_success() {
        do {
            let jsonData = getJsonData(from: "LaunchData")
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let launch = try decoder.decode(Launch.self, from: jsonData)
            XCTAssertEqual(launch.flightNumber, 60)
            XCTAssertEqual(launch.youtubeID, "0a_00nJ_Y88")
        } catch {
            XCTFail("Can't decode data")
        }
    }

    func test_decode_Launchs_failure() {
        let jsonData = getJsonData(from: "LaunchNilData")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let launch = try? decoder.decode(Launch.self, from: jsonData)
        XCTAssertNil(launch)
    }
}
