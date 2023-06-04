//
//  AppDelegate.swift
//  Currency
//
//  Created by Mohamed Salah on 02/06/2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	var appFlowCoordinator: AppFlowCoordinator?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		window = UIWindow(frame: UIScreen.main.bounds)
		
		let navigationController = UINavigationController()
		window?.rootViewController = navigationController
		
		appFlowCoordinator = AppFlowCoordinator(navigationController: navigationController)
		appFlowCoordinator?.start()
		
		window?.makeKeyAndVisible()
		
		return true
	}
}

