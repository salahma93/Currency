//
//  AvailableCurrenciesUseCaseProtocol.swift
//  Currency
//
//  Created by Mohamed Salah on 02/06/2023.
//

import Foundation

protocol AvailableCurrenciesUseCaseProtocol {
	func getCurrencySymbols(completion: @escaping (Result<[String], Error>) -> Void)
}
