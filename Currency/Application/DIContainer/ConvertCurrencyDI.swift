//
//  ConvertCurrencyDI.swift
//  Currency
//
//  Created by Mohamed Salah on 04/06/2023.
//

import UIKit

struct ConvertCurrencyDI {
	let appContainer = AppDIContainer.shared.container
	let convertCurrencyContainer = DependencyContainer()
	
	init() {
		register()
	}
	
	func makeConvertCurrencyView() -> UIViewController {
		let viewModel = convertCurrencyContainer.resolve(ConvertCurrencyViewModelProtocol.self)
		return ConvertCurrencyViewController(viewModel: viewModel)
	}
	
	func register() {
		convertCurrencyContainer.register(AvailableCurrenciesUseCaseProtocol.self) {
			let repository = appContainer.resolve(CurrencyRatesRepository.self)
			return AvailableCurrenciesUseCase(currencyRepository: repository)
		}
		
		convertCurrencyContainer.register(ConvertCurrencyUseCaseProtocol.self) {
			let repository = appContainer.resolve(CurrencyRatesRepository.self)
			return CurrencyConversionUseCase(currencyRepository: repository)
		}
		
		convertCurrencyContainer.register(ConvertCurrencyViewModelProtocol.self) {
			let availableCurrenciesUseCase = convertCurrencyContainer.resolve(AvailableCurrenciesUseCaseProtocol.self)
			let currencyConversionUseCase = convertCurrencyContainer.resolve(ConvertCurrencyUseCaseProtocol.self)
			
			return ConvertCurrencyViewModel(availableCurrenciesUseCase: availableCurrenciesUseCase,
											currencyConversionUseCase: currencyConversionUseCase)
		}
	}
}
