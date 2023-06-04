//
//  ConvertCurrencyViewModel.swift
//  Currency
//
//  Created by Mohamed Salah on 02/06/2023.
//

import Foundation
import RxSwift

class ConvertCurrencyViewModel: ConvertCurrencyViewModelProtocol {	
	//MARK: - Variables
	private let availableCurrenciesUseCase: AvailableCurrenciesUseCaseProtocol
	private let currencyConversionUseCase: ConvertCurrencyUseCaseProtocol
		
	var symbols: PublishSubject<[String]> = PublishSubject()
	var convertedAmount: PublishSubject<String> = PublishSubject()
	
	//MARK: - init(s)
	init(availableCurrenciesUseCase: AvailableCurrenciesUseCaseProtocol,
		 currencyConversionUseCase: ConvertCurrencyUseCaseProtocol) {
		self.availableCurrenciesUseCase = availableCurrenciesUseCase
		self.currencyConversionUseCase = currencyConversionUseCase
	}
	
	func start() {
		availableCurrenciesUseCase.getCurrencySymbols { result in
			switch result {
			case .success(let symbols):
				self.symbols.onNext(symbols)
			case .failure(let error):
				self.symbols.onError(error)
			}
		}
	}
	
	func convert(from: String?, to: String?, amount: String?) {
		guard let from = from, let to = to, let amount = amount else {
			convertedAmount.onError(CurrencyConversionError.missingInfo)
			return
		}
		
		guard let doubleAmount = Double(amount) else {
			convertedAmount.onError(CurrencyConversionError.wrongAmount)
			return
		}
		
		let convertModel = CurrencyConversionModel(from: from, to: to, amount: doubleAmount)
		
		currencyConversionUseCase.convertCurrency(with: convertModel) { result in
			switch result {
			case .success(let convertedAmount):
				self.convertedAmount.onNext(String(convertedAmount))
				
			case .failure(let error):
				self.convertedAmount.onError(error)
			}
		}
	}
}
