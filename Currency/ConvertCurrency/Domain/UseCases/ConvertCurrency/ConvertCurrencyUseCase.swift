//
//  ConvertCurrencyUseCase.swift
//  Currency
//
//  Created by Mohamed Salah on 02/06/2023.
//

import Foundation

class CurrencyConversionUseCase: ConvertCurrencyUseCaseProtocol {
	private let currencyRepository: CurrencyRatesRepository
	
	init(currencyRepository: CurrencyRatesRepository) {
		self.currencyRepository = currencyRepository
	}
	
	func convertCurrency(with model: CurrencyConversionModel,
						 completion: @escaping (Result<Double, Error>) -> Void) {
		
		currencyRepository.getLatestRates(for: model.currencySymbolsList) { [weak self] result in
			switch result {
			case .success(let currencyRates):
				do {
					let convertedAmount = try self?.convert(model, with: currencyRates)
					completion(.success(convertedAmount ?? 0.0))
					
				} catch {
					completion(.failure(error))
				}
				
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	//MARK: - Private Methods
	private func convert(_ model: CurrencyConversionModel, with rates: CurrencyRates) throws -> Double {
		guard rates.base != model.to else {
			return try model.amount / rates.rate(for: model.from)
		}
		
		guard rates.base != model.from else {
			return try model.amount * rates.rate(for: model.to)
		}
		
		let amountToBaseCurrency = try model.amount / rates.rate(for: model.from)
		let finalConvertedAmount = try amountToBaseCurrency * rates.rate(for: model.to)
		
		return round(finalConvertedAmount * 100) / 100.0
	}
}
