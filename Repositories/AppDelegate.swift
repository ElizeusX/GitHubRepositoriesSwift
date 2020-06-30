//
//  AppDelegate.swift
//  Repositories
//
//  Created by Elizeus on 05/06/2020.
//  Copyright © 2020 Elizeus. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        showRepositoryView()
        
        return true
    }
    
    
    private func showRepositoryView(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let navigationView = storyboard.instantiateViewController(withIdentifier: "RepositoryNavigationController") as? UINavigationController
            else {
                return
        }
        
        guard let repositoryView = navigationView.viewControllers.first as? RepositoryViewController
                 else {
                     return
             }
        
        let presenter = RepositoryPresenter(view: repositoryView)
        repositoryView.presenter = presenter
        setRootViewController(navigationView)
    }
    
    private func setRootViewController(_ controller: UIViewController) {
        guard let window = window else {
            return
        }
        
        window.rootViewController = controller
        if !window.isKeyWindow {
            window.makeKeyAndVisible()
        }
    }
    
    
    
    
}

