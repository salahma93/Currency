//
//  ConvertCurrencyUseCase.swift
//  Currency
//
//  Created by Mohamed Salah on 02/06/2023.
//

import Foundation

class CurrencyConversionUseCase {
	private let currencyRepository: CurrencyRatesRepository
	
	init(currencyRepository: CurrencyRatesRepository) {
		self.currencyRepository = currencyRepository
	}
	
	func convertCurrency(from: String, to: String, amount: Double,
						 completion: @escaping (Result<Double, Error>) -> Void) {
		
		currencyRepository.getLatestRates(for: []) { result in
			switch result {
			case .success(let convertedAmount):
				completion(.success(0.0))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
