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

struct CurrencyRates {
	let base: String
	let rates: [String: Double]
	
	init(from response: CurrencyRatesResponse) {
		self.base = response.base
		self.rates = response.rates
	}
}
