//
//  DependencyContainer.swift
//  Currency
//
//  Created by Mohamed Salah on 04/06/2023.
//

import Foundation

class DependencyContainer {
	private var services = [String: Any]()
	private var factories = [String: Any]()
	
	func register<Service>(_ serviceType: Service.Type, instance: Service) {
		let key = "\(Service.self)"
		services[key] = instance
	}
	
	func register<Service>(_ serviceType: Service.Type, factory: @escaping () -> Service) {
		let key = "\(Service.self)"
		factories[key] = factory
	}
	
	func resolve<Service>(_ serviceType: Service.Type) -> Service {
		let key = "\(Service.self)"
		if let service = services[key] as? Service {
			return service
		} else if let factory = factories[key] as? () -> Service {
			let service = factory()
			services[key] = service
			return service
		} else {
			fatalError("\(serviceType) is not registered")
		}
	}
}
