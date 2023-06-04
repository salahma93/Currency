//
//  ThreadSafeNetworkManager.swift
//  Currency
//
//  Created by Mohamed Salah on 04/06/2023.
//

import Foundation

class ThreadSafeNetworkManager: NetworkManagerProtocol {
	private let wrapped: NetworkManagerProtocol
	private let queue = DispatchQueue(label: "com.example.ThreadSafeNetworkManager", attributes: .concurrent)
	
	init(_ networkManager: NetworkManagerProtocol) {
		self.wrapped = networkManager
	}
	
	func load<T: Codable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
		queue.async { [weak self] in
			self?.wrapped.load(request: request) { result in
				DispatchQueue.main.async {
					completion(result)
				}
			}
		}
	}
	
	func cancel() {
		queue.async { [weak self] in
			self?.wrapped.cancel()
		}
	}
}
