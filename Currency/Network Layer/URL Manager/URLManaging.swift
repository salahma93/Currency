//
//  URLManaging.swift
//  Currency
//
//  Created by Mohamed Salah on 03/06/2023.
//

import Foundation

protocol URLManaging {
	var serviceURLKey: String { get }
}

extension URLManaging {
	func getURL(for key: String) -> URL? {
		URLManager.url(forKey: key)
	}
}
