//
//  ConvertCurrencyUseCaseProtocol.swift
//  Currency
//
//  Created by Mohamed Salah on 02/06/2023.
//

import Foundation

protocol ConvertCurrencyUseCaseProtocol {
	func convertCurrency(from: String, to: String, amount: Double,
						 completion: @escaping (Result<Double, Error>) -> Void)
}
