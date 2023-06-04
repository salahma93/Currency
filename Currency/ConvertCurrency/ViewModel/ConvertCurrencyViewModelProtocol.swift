//
//  ConvertCurrencyViewModelProtocol.swift
//  Currency
//
//  Created by Mohamed Salah on 02/06/2023.
//

import Foundation
import RxSwift

protocol ConvertCurrencyViewModelProtocol {
	var symbols: PublishSubject<[String]> { get }
	var convertedAmount: PublishSubject<String> { get }
	var errorsSubject: PublishSubject<Error?> { get }
	
	func start()
	func convert(from: String?, to: String?, amount: String?)
}
