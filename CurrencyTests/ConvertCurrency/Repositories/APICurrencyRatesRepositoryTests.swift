//
//  APICurrencyRatesRepositoryTests.swift
//  CurrencyTests
//
//  Created by Mohamed Salah on 04/06/2023.
//

import XCTest
@testable import Currency

final class APICurrencyRatesRepositoryTests: XCTestCase {
	
	// MARK: - Mocks
	class MockRequestMethod: RequestMethodProtocol {
		func configure(request: URLRequest, with parameters: [String: String?]) -> URLRequest {
			// Do nothing for testing purposes
			return request
		}
	}
	
	// MARK: - Tests
	
	func testGetLatestRates_SuccessfulResponse() {
		// Given
		let expectation = self.expectation(description: "Completion called")
		let symbols = ["USD", "EUR"]
		
		let networkManager = MockedNetworkManager()
		let requestMethod = MockRequestMethod()
		
		let repository = APICurrencyRatesRepository(networkManager: networkManager, requestMethod: requestMethod)
		
		// When
		repository.getLatestRates(for: symbols) { result in
			// Then

			switch result {
			case .success(var currencyRates):
				XCTAssertEqual(currencyRates.base, "EUR")
				XCTAssertEqual(currencyRates.symbols.count, 170)
				XCTAssertEqual(try! currencyRates.rate(for: "USD"), 1.072558)
				XCTAssertEqual(try! currencyRates.rate(for: "EGP"), 33.085165)
				
			case .failure(let error):
				XCTFail("Unexpected error: \(error)")
			}
			expectation.fulfill()
		}
		
		waitForExpectations(timeout: 1, handler: nil)
	}
	
	func testGetLatestRates_FailureResponse() {
		// Given
		let expectation = self.expectation(description: "Completion called")
		let symbols = ["USD", "EUR"]
		
		var networkManager = MockedNetworkManager()
		networkManager.setFailure(error: NetworkError.invalidResponse)
		
		let requestMethod = MockRequestMethod()
		
		let repository = APICurrencyRatesRepository(networkManager: networkManager, requestMethod: requestMethod)
		
		// When
		repository.getLatestRates(for: symbols) { result in
			// Then
			switch result {
			case .success:
				XCTFail("Expected failure, but received success")
				
			case .failure(let error):
				XCTAssertEqual(error as? NetworkError, NetworkError.invalidResponse)
			}
			
			expectation.fulfill()
		}
		
		waitForExpectations(timeout: 1, handler: nil)
	}
	
	// ... More test cases
	
}

