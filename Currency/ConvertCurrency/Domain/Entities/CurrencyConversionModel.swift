//
//  CurrencyConversionModel.swift
//  Currency
//
//  Created by Mohamed Salah on 03/06/2023.
//

import Foundation

struct CurrencyConversionModel {
	let from: String
	let to: String
	let amount: Double
}

extension CurrencyConversionModel {
	var currencySymbolsList: [String] {
		[from, to]
	}
}

//MARK: - Currency Conversion Errors
enum CurrencyConversionError: Error {
	case missingInfo
	case wrongAmount
}

extension CurrencyConversionError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .missingInfo:
			return "There is a Missing Info"
			
		case .wrongAmount:
			return "The Entered Amount is wrong"
		}
	}
}
