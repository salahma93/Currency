//
//  ConvertCurrencyUseCase.swift
//  Currency
//
//  Created by Mohamed Salah on 02/06/2023.
//

import Foundation

class CurrencyConversionUseCase {
	private let currencyRepository: CurrencyConversionRepository
	
	init(currencyRepository: CurrencyConversionRepository) {
		self.currencyRepository = currencyRepository
	}
	
	func convertCurrency(from: String, to: String, amount: Double,
						 completion: @escaping (Result<Double, Error>) -> Void) {
		
		currencyRepository.convertCurrency(from: from, to: to, amount: amount) { result in
			switch result {
			case .success(let convertedAmount):
				completion(.success(convertedAmount))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
