//
//  ConvertCurrencyViewModel.swift
//  Currency
//
//  Created by Mohamed Salah on 02/06/2023.
//

import Foundation

struct ConvertCurrencyViewModel: ConvertCurrencyViewModelProtocol {
	//MARK: - Variables
	private let availableCurrenciesUseCase: AvailableCurrenciesUseCaseProtocol
	private let currencyConversionUseCase: ConvertCurrencyUseCaseProtocol
	
	//MARK: - init(s)
	init(availableCurrenciesUseCase: AvailableCurrenciesUseCaseProtocol,
		 currencyConversionUseCase: ConvertCurrencyUseCaseProtocol) {
		self.availableCurrenciesUseCase = availableCurrenciesUseCase
		self.currencyConversionUseCase = currencyConversionUseCase
	}
}
