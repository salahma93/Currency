//
//  AppFlowCoordinator.swift
//  Currency
//
//  Created by Mohamed Salah on 04/06/2023.
//

import UIKit

final class AppFlowCoordinator {
	var navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func start() {
		let convertCurrencyVC = ConvertCurrencyDI().makeConvertCurrencyView()
		navigationController.viewControllers = [convertCurrencyVC]
	}
}
