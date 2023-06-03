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
