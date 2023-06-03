//
//  GETRequestMethod.swift
//  Currency
//
//  Created by Mohamed Salah on 03/06/2023.
//

import Foundation

struct GETRequestMethod: RequestMethodProtocol {
	func configure(request: URLRequest, with params: [String: String?]) -> URLRequest {
		guard let url = request.url else {
			return request
		}
		
		var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
		components?.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
		
		if let urlWithQuery = components?.url {
			var request = URLRequest(url: urlWithQuery)
			request.httpMethod = "GET"
			
			return request
		} else {
			return request
		}
	}
}
