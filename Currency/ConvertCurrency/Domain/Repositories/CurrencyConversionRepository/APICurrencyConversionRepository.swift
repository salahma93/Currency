//
//  APICurrencyConversionRepository.swift
//  Currency
//
//  Created by Mohamed Salah on 02/06/2023.
//

import Foundation

class APICurrencyConversionRepository: CurrencyConversionRepository, NetworkServiceProtocol {
	var serviceURLKey: String = "currency-convert"
	let networkManager: NetworkManagerProtocol
	
	//MARK: - init
	init(networkManager: NetworkManagerProtocol) {
		self.networkManager = networkManager
	}
	
	//MARK: - CurrencyConversionRepository
	func convertCurrency(from: String, to: String, amount: Double, completion: @escaping ConversionCompletion) {
		// Make API call to retrieve the conversion rate
		// Parse the response and calculate the converted amount
		// Invoke the completion handler with the result or error
	}
	
	// MARK: - NetworkServiceProtocol Methods
	func start<ParamsModel: Encodable, ResponseModel: Codable>(with params: ParamsModel, completion: @escaping (Result<ResponseModel, Error>) -> Void) {
		
	}
	
	func cancel() {
		networkManager.cancel()
	}
}
