//
//  CurrencyRates.swift
//  Currency
//
//  Created by Mohamed Salah on 03/06/2023.
//

import Foundation

struct CurrencyRatesResponse: Codable {
	let success: Bool
	let timestamp: TimeInterval
	let base: String
	let date: String
	let rates: [String: Double]
}

//MARK: - CurrencyRates
struct CurrencyRates {
	let base: String
	private let rates: [String: Double]
	
	//MARK: - init(s)
	init(from response: CurrencyRatesResponse) {
		self.base = response.base
		self.rates = response.rates
	}
	
	init(base: String, rates: [String: Double]) {
		self.base = base
		self.rates = rates
	}
	
	//MARK: - calculated properties
	lazy var symbols: [String] = {
		Array(rates.keys)
	}()
	
	func rate(for symbol: String) throws -> Double {
		if let rate = rates[symbol] {
			return rate
		} else {
			throw CurrencyRateError.notAvailable
		}
	}
}

//MARK: - Error Enum
enum CurrencyRateError: Error {
	case notAvailable
}

extension CurrencyRateError: LocalizedError {
	var errorDescription: String? {
		return "Currency Rates not available right now"
	}
}
