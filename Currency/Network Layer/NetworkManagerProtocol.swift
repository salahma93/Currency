//
//  NetworkManagerProtocol.swift
//  Currency
//
//  Created by Mohamed Salah on 02/06/2023.
//

import Foundation

protocol NetworkManagerProtocol {
	func load<T: Codable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void)
	func cancel()
}

enum NetworkError: Error {
	case invalidResponse
}
