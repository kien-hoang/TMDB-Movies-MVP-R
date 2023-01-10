//
//  AppDelegate.swift
//  TMDB-Movies-MVP
//
//  Created by Bradley Hoang on 28/12/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Public Variable
    
    var window: UIWindow?
    
    // MARK: - Private Variable
    
    private var appRouter: AppRouter?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        appRouter = AppRouter(window: window!)
        appRouter?.showAsRootView()
        return true
    }
}
