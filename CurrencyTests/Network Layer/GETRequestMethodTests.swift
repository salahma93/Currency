//
//  GETRequestMethodTests.swift
//  CurrencyTests
//
//  Created by Mohamed Salah on 03/06/2023.
//

import XCTest
@testable import Currency

final class GETRequestMethodTests: XCTestCase {
	
	func testConfigureGETRequest() {
		// Given
		let url = URL(string: "https://example.com/api")!
		let request = URLRequest(url: url)
		let params = ["q": "example"]
		let expectedURL = URL(string: "https://example.com/api?q=example")!
		
		// When
		let method = GETRequestMethod()
		let configuredRequest = method.configure(request: request, with: params)
		
		// Then
		XCTAssertEqual(configuredRequest.url, expectedURL)
		XCTAssertEqual(configuredRequest.httpMethod, "GET")
	}
	
	func testConfigureGETRequestWithEmptyParams() {
		// Given
		let url = URL(string: "https://example.com/api?")!
		let request = URLRequest(url: url)
		let params: [String: String?] = [:]
		
		// When
		let method = GETRequestMethod()
		let configuredRequest = method.configure(request: request, with: params)
		
		// Then
		XCTAssertEqual(configuredRequest.url, url)
		XCTAssertEqual(configuredRequest.httpMethod, "GET")
	}
}

