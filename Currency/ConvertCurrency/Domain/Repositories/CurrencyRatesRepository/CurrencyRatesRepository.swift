//
//  CurrencyRatesRepository.swift
//  Currency
//
//  Created by Mohamed Salah on 02/06/2023.
//

import Foundation

protocol CurrencyRatesRepository {
	typealias RatesCompletion = (Result<CurrencyRates, Error>) -> Void
	func getLatestRates(for symbols: [String], completion: @escaping RatesCompletion)
}
