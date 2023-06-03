//
//  URLManager.swift
//  Currency
//
//  Created by Mohamed Salah on 03/06/2023.
//

import Foundation

struct URLManager {
	
	private static var urlCache: [String: URL] = [:]
	
	static func url(forKey key: String) -> URL? {
		if let cachedURL = urlCache[key] {
			return cachedURL
		}
		
		guard let plistURL = Bundle.main.url(forResource: "URLs", withExtension: "plist"),
			  let plistData = try? Data(contentsOf: plistURL),
			  let plist = try? PropertyListSerialization.propertyList(from: plistData, options: [], format: nil) as? [String: String],
			  let urlString = plist[key],
			  let url = URL(string: urlString)
		else {
			return nil
		}
		
		urlCache[key] = url
		return url
	}
	
}
