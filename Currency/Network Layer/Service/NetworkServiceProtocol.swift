//
//  NetworkServiceProtocol.swift
//  Currency
//
//  Created by Mohamed Salah on 02/06/2023.
//

import Foundation

protocol NetworkServiceProtocol: URLManaging {
	func start<ParamsModel: Encodable, ResponseModel: Codable>(with params: ParamsModel, completion: @escaping (Result<ResponseModel, Error>) -> Void)
	
	func cancel()
}
