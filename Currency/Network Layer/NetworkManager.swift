//
//  NetworkManager.swift
//  Currency
//
//  Created by Mohamed Salah on 02/06/2023.
//

import Foundation

class NetworkManager: NetworkManagerProtocol {
	private var task: URLSessionDataTask?
	
	// MARK: - NetworkManagerProtocol Methods
	func load<T: Codable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
		task = URLSession.shared
			.dataTask(with: request, completionHandler: { [weak self] data, response, error in
				if let error = error {
					completion(.failure(error))
					return
				}
				
				guard let data = data  else {
					completion(.failure(NetworkError.invalidResponse))
					return
				}
				
				self?.handleResponse(json: data, completion: completion)
			})
		
		task?.resume()
	}
	
	func cancel() {
		task?.cancel()
	}
	
	//MARK: - private methods
	private func handleResponse<T: Codable>(json: Data, completion: @escaping (Result<T, Error>) -> Void) {
		do {
			let decoder = JSONDecoder()
			let object = try decoder.decode(T.self, from: json)
			
			completion(.success(object))
		} catch {
			completion(.failure(error))
		}
	}
}
