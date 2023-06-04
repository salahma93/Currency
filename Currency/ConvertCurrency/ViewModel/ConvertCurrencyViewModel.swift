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
	var errorsSubject: PublishSubject<Error?> = PublishSubject()
	
	//MARK: - init(s)
	init(availableCurrenciesUseCase: AvailableCurrenciesUseCaseProtocol,
		 currencyConversionUseCase: ConvertCurrencyUseCaseProtocol) {
		self.availableCurrenciesUseCase = availableCurrenciesUseCase
		self.currencyConversionUseCase = currencyConversionUseCase
	}
	
	func start() {
		availableCurrenciesUseCase.getCurrencySymbols { [weak self] result in
			switch result {
			case .success(let symbols):
				self?.errorsSubject.onNext(nil)
				self?.symbols.onNext(symbols)
				
			case .failure(let error):
				self?.errorsSubject.onNext(error)
			}
		}
	}
	
	func convert(from: String?, to: String?, amount: String?) {
		guard let from = from, let to = to, let amount = amount else {
			errorsSubject.onNext(CurrencyConversionError.missingInfo)
			return
		}
		
		guard let doubleAmount = Double(amount) else {
			errorsSubject.onNext(CurrencyConversionError.wrongAmount)
			return
		}
		
		let convertModel = CurrencyConversionModel(from: from, to: to, amount: doubleAmount)
		
		currencyConversionUseCase.convertCurrency(with: convertModel) { [weak self] result in
			switch result {
			case .success(let convertedAmount):
				self?.errorsSubject.onNext(nil)
				self?.convertedAmount.onNext(String(convertedAmount))
				
			case .failure(let error):
				self?.errorsSubject.onNext(error)
			}
		}
	}
}
