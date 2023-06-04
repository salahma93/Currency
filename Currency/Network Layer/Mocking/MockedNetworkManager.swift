//
//  MockedNetworkManager.swift
//  Currency
//
//  Created by Mohamed Salah on 03/06/2023.
//

import Foundation

/**
 This struct is created to mock the response during development as the API subscription has a limit on the number of requests.
 
 Use this `MockedNetworkManager` class as a substitute for the actual `NetworkManager` during development to simulate network requests and responses. It allows you to test different scenarios and avoid exceeding the API request limit while working on your project.
 
 - Note: This class should be used only for development and testing purposes and should not be used in production code.
 
 Conform to the `NetworkManagerProtocol` to ensure compatibility with the rest of the network-related components in your project.
 */

struct MockedNetworkManager: NetworkManagerProtocol {
	private var failureError: Error?
	
	func load<T>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
		if let error = failureError {
			completion(.failure(error))
			return
		}
		
		do {
			let json = try getJSON()
			let jsonData = Data(json.utf8)
			let decoder = JSONDecoder()
			
			let response = try decoder.decode(T.self, from: jsonData)
			completion(.success(response))
			
		} catch {
			completion(.failure(NetworkError.invalidResponse))
		}
		
	}
	
	mutating func setFailure(error: Error?) {
		failureError = error
	}
	
	func cancel() {
		//No Need to be implemented
	}
	
	private func getJSON() throws -> String {
		guard let filePath = Bundle.main.path(forResource: "response", ofType: "json") else {
			throw NetworkError.invalidResponse
		}

		do {
			let fileURL = URL(fileURLWithPath: filePath)
			let jsonData = try Data(contentsOf: fileURL)
			
			if let jsonString = String(data: jsonData, encoding: .utf8) {
				return jsonString
			} else {
				throw NetworkError.invalidResponse
			}
			
		} catch {
			throw NetworkError.invalidResponse
		}
	}
}
