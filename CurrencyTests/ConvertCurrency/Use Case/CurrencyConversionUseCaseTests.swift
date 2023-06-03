//
//  CurrencyConversionUseCaseTests.swift
//  CurrencyTests
//
//  Created by Mohamed Salah on 03/06/2023.
//

import XCTest
@testable import Currency

final class CurrencyConversionUseCaseTests: XCTestCase {
	
	var currencyRepositoryMock: CurrencyRatesRepositoryMock!
	var useCase: CurrencyConversionUseCase!
	
	override func setUp() {
		super.setUp()
		
		currencyRepositoryMock = CurrencyRatesRepositoryMock()
		useCase = CurrencyConversionUseCase(currencyRepository: currencyRepositoryMock)
	}
	
	override func tearDown() {
		currencyRepositoryMock = nil
		useCase = nil
		
		super.tearDown()
	}
	
	func testConvertCurrency_Success() {
		let conversionModel = CurrencyConversionModel(from: "USD", to: "EUR", amount: 100.0)
		let currencyRates = CurrencyRates(base: "USD", rates: ["EUR": 0.85])
		currencyRepositoryMock.latestRatesResult = .success(currencyRates)
		
		let expectation = XCTestExpectation(description: "Conversion completed")
		
		useCase.convertCurrency(with: conversionModel) { result in
			switch result {
			case .success(let convertedAmount):
				XCTAssertEqual(convertedAmount, 85.0, accuracy: 0.01)
				expectation.fulfill()
				
			case .failure(let error):
				XCTFail("Conversion failed with error: \(error)")
			}
		}
		
		wait(for: [expectation], timeout: 1.0)
	}
	
	func testConvertCurrency_ZeroAmount() {
		let conversionModel = CurrencyConversionModel(from: "USD", to: "EUR", amount: 0.0)
		let currencyRates = CurrencyRates(base: "USD", rates: ["EUR": 0.85])
		currencyRepositoryMock.latestRatesResult = .success(currencyRates)
		
		let expectation = XCTestExpectation(description: "Conversion completed")
		
		useCase.convertCurrency(with: conversionModel) { result in
			switch result {
			case .success(let convertedAmount):
				XCTAssertEqual(convertedAmount, 0.0, accuracy: 0.01)
				expectation.fulfill()
			case .failure(let error):
				XCTFail("Conversion failed with error: \(error)")
			}
		}
		
		wait(for: [expectation], timeout: 1.0)
	}

	func testConvertCurrency_SameCurrencies() {
		let conversionModel = CurrencyConversionModel(from: "USD", to: "USD", amount: 100.0)
		let currencyRates = CurrencyRates(base: "USD", rates: ["USD": 1.0])
		currencyRepositoryMock.latestRatesResult = .success(currencyRates)
		
		let expectation = XCTestExpectation(description: "Conversion completed")
		
		useCase.convertCurrency(with: conversionModel) { result in
			switch result {
			case .success(let convertedAmount):
				XCTAssertEqual(convertedAmount, 100.0, accuracy: 0.01)
				expectation.fulfill()
			case .failure(let error):
				XCTFail("Conversion failed with error: \(error)")
			}
		}
		
		wait(for: [expectation], timeout: 1.0)
	}

	func testConvertCurrency_BaseCurrencyNotFound() {
		let conversionModel = CurrencyConversionModel(from: "USD", to: "EUR", amount: 100.0)
		let currencyRates = CurrencyRates(base: "GBP", rates: ["EUR": 0.85])
		currencyRepositoryMock.latestRatesResult = .success(currencyRates)
		
		let expectation = XCTestExpectation(description: "Conversion failed")
		
		useCase.convertCurrency(with: conversionModel) { result in
			switch result {
			case .success:
				XCTFail("Conversion succeeded unexpectedly")
			case .failure(let error):
				XCTAssertNotNil(error)
				expectation.fulfill()
			}
		}
		
		wait(for: [expectation], timeout: 1.0)
	}

	
	func testConvertCurrency_Failure() {
		let conversionModel = CurrencyConversionModel(from: "USD", to: "EUR", amount: 100.0)
		let error = NSError(domain: "MockErrorDomain", code: 0, userInfo: nil)
		currencyRepositoryMock.latestRatesResult = .failure(error)
		
		let expectation = XCTestExpectation(description: "Conversion failed")
		
		useCase.convertCurrency(with: conversionModel) { result in
			switch result {
			case .success:
				XCTFail("Conversion succeeded unexpectedly")
				
			case .failure(let error):
				XCTAssertNotNil(error)
				expectation.fulfill()
			}
		}
		
		wait(for: [expectation], timeout: 1.0)
	}
}

//MARK: - Mock implementation of CurrencyRatesRepository
class CurrencyRatesRepositoryMock: CurrencyRatesRepository {
	var latestRatesResult: Result<CurrencyRates, Error>?
	
	func getLatestRates(for currencies: [String], completion: @escaping (Result<CurrencyRates, Error>) -> Void) {
		if let result = latestRatesResult {
			completion(result)
		}
	}
}
