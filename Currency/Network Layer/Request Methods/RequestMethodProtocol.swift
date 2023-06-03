//
//  GETRequestMethod.swift
//  Currency
//
//  Created by Mohamed Salah on 03/06/2023.
//

import Foundation

protocol RequestMethodProtocol {
	func configure(request: URLRequest, with params: [String: String?]) -> URLRequest
}
