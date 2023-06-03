//
//  AvailableCurrenciesUseCase.swift
//  Currency
//
//  Created by Mohamed Salah on 02/06/2023.
//

import Foundation

class AvailableCurrenciesUseCase: AvailableCurrenciesUseCaseProtocol {
	private let currencyRepository: CurrencyRatesRepository
	
	init(currencyRepository: CurrencyRatesRepository) {
		self.currencyRepository = currencyRepository
	}
	
	func getCurrencySymbols(completion: @escaping (Result<[String], Error>) -> Void) {
		currencyRepository.getLatestRates(for: []) { result in
			switch result {
			case .success(var currencyRates):
				completion(.success(currencyRates.symbols))
				
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
