//
//  AvailableCurrenciesUseCaseTests.swift
//  CurrencyTests
//
//  Created by Mohamed Salah on 03/06/2023.
//

import XCTest
@testable import Currency

final class AvailableCurrenciesUseCaseTests: XCTestCase {
	
	var currencyRepositoryMock: CurrencyRatesRepositoryMock!
	var useCase: AvailableCurrenciesUseCase!
	
	override func setUp() {
		super.setUp()
		
		currencyRepositoryMock = CurrencyRatesRepositoryMock()
		useCase = AvailableCurrenciesUseCase(currencyRepository: currencyRepositoryMock)
	}
	
	override func tearDown() {
		currencyRepositoryMock = nil
		useCase = nil
		
		super.tearDown()
	}
	
	func testGetCurrencySymbols_Success() {
		let currencySortedSymbols = ["EUR", "GBP", "USD"]
		let currencyRates = CurrencyRates(base: "USD", rates: ["USD": 39.0, "EUR": 30.0, "GBP": 2.2])
		currencyRepositoryMock.latestRatesResult = .success(currencyRates)
		
		let expectation = XCTestExpectation(description: "Currency symbols fetched")
		
		useCase.getCurrencySymbols { result in
			switch result {
			case .success(let symbols):
				XCTAssertEqual(symbols, currencySortedSymbols)
				expectation.fulfill()
				
			case .failure(let error):
				XCTFail("Failed to fetch currency symbols with error: \(error)")
			}
		}
		
		wait(for: [expectation], timeout: 1.0)
	}
	
	func testGetCurrencySymbols_Failure() {
		let error = NSError(domain: "MockErrorDomain", code: 0, userInfo: nil)
		currencyRepositoryMock.latestRatesResult = .failure(error)
		
		let expectation = XCTestExpectation(description: "Failed to fetch currency symbols")
		
		useCase.getCurrencySymbols { result in
			switch result {
			case .success:
				XCTFail("Unexpectedly fetched currency symbols")
				
			case .failure(let error):
				XCTAssertNotNil(error)
				expectation.fulfill()
			}
		}
		
		wait(for: [expectation], timeout: 1.0)
	}
}

