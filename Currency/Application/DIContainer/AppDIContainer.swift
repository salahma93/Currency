//
//  AppDIContainer.swift
//  Currency
//
//  Created by Mohamed Salah on 04/06/2023.
//

import Foundation

class AppDIContainer {
	static var shared = AppDIContainer()
	let container = DependencyContainer()
	
	init() {
		// Register Core Classes
		container.register(NetworkManagerProtocol.self) {
			ThreadSafeNetworkManager(NetworkManager())
		}
		
		container.register(CurrencyRatesRepository.self) {
			let networkManager = self.container.resolve(NetworkManagerProtocol.self)
			
			return APICurrencyRatesRepository(networkManager: networkManager,
											  requestMethod: GETRequestMethod())
		}
	}
}
