//
//  CurrencyConversionRepository.swift
//  Currency
//
//  Created by Mohamed Salah on 02/06/2023.
//

import Foundation

protocol CurrencyConversionRepository {
	typealias ConversionCompletion = (Result<Double, Error>) -> Void
	
	func convertCurrency(from: String, to: String, amount: Double,
						 completion: @escaping ConversionCompletion)
}
