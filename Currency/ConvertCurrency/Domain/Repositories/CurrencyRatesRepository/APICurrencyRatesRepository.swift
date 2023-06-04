//
//  APICurrencyRatesRepository.swift
//  Currency
//
//  Created by Mohamed Salah on 02/06/2023.
//

import Foundation

class APICurrencyRatesRepository: CurrencyRatesRepository, URLManaging {
	var serviceURLKey: String = "latest-rates"
	
	private let networkManager: NetworkManagerProtocol
	private let requestMethod: RequestMethodProtocol
	
	//MARK: - init
	init(networkManager: NetworkManagerProtocol, requestMethod: RequestMethodProtocol) {
		self.networkManager = networkManager
		self.requestMethod = requestMethod
	}
	
	//MARK: - CurrencyRatesRepository
	func getLatestRates(for symbols: [String], completion: @escaping RatesCompletion) {
		cancelRunningTask()
		requestLatestRates(for: symbols, completion: completion)
	}
	
	private func requestLatestRates(for symbols: [String], completion: @escaping RatesCompletion) {
		guard let url = getURL(for: serviceURLKey) else {
			return
		}
		
		let params = buildParametersDictionary(with: symbols)
		let request = requestMethod.configure(request: URLRequest(url: url), with: params)
		networkManager.load(request: request) { (result: Result<CurrencyRatesResponse, Error>) in
			switch result {
			case .success(let response):
				completion(.success(CurrencyRates(from: response)))
						   
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	//MARK: - util private methods
	private func buildParametersDictionary(with symbols: [String]) -> [String: String?] {
		var paramsDictionary: [String: String?] = [
			"access_key": "7f008d37e57dbbd48bbeeda572d85c1f",
			"format": "1"
		]
		
		if symbols.count > 0 {
			paramsDictionary["symbols"] = symbols.joined(separator: ",")
		}
		
		return paramsDictionary
	}
	
	private func cancelRunningTask() {
		networkManager.cancel()
	}
}
