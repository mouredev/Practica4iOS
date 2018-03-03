//
//  AppDelegate.swift
//  Westeros
//
//  Created by Brais Moure on 8/2/18.
//  Copyright © 2018 Brais Moure. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private var tabBarDetailControllers: [UINavigationController]!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Default appearance
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.black, NSAttributedStringKey.font: UIFont.init(name: "Game of Thrones", size: 20.0)!]
        
        // Window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.tintColor = UIColor.black
        window?.makeKeyAndVisible()
        
        // Creamos los combinadores
        /*let tabBarViewController = UITabBarController()
         tabBarViewController.viewControllers = Repository.local.houses
         .map{ house in
         return HouseDetailViewController(model: house).wrappedInNavigation()
         }*/
        
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons
        
        // Creamos los controladores y combinadores (masterVC, detailVC)
        let houseListViewController = HouseListViewController(model: houses)
        let seasonListViewController = SeasonListViewController(model: seasons)
        let tabBarIcon = UIImage(named: "back")
        houseListViewController.tabBarItem.image = tabBarIcon
        seasonListViewController.tabBarItem.image = tabBarIcon
        
        let lastSelectedHouse = houseListViewController.lastSelectedHouse()
        let houseDetailViewController = HouseDetailViewController(model: lastSelectedHouse)
        let seasonDetailViewController = SeasonDetailViewController(model: seasons.first!)
        
        // Almacenamos los controladores de detalle del split controller
        tabBarDetailControllers = [houseDetailViewController.wrappedInNavigation(), seasonDetailViewController.wrappedInNavigation()]
        
        let tabBarViewController = UITabBarController()
        tabBarViewController.viewControllers = [houseListViewController.wrappedInNavigation(), seasonListViewController.wrappedInNavigation()]
        tabBarViewController.delegate = self
        
        // Asignamos delegados
        houseListViewController.delegate = houseDetailViewController
        seasonListViewController.delegate = seasonDetailViewController
        
        // Creamos el UISplitViewController y le asignamos los controllers
        let splitViewController = UISplitViewController()
        splitViewController.viewControllers = [
            tabBarViewController,
            tabBarDetailControllers.first!
        ]
        splitViewController.preferredDisplayMode = .allVisible
        splitViewController.delegate = self
        
        // Asignamos el rootVC
        //window?.rootViewController = tabBarViewController
        //window?.rootViewController = houseListViewController
        window?.rootViewController = splitViewController
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}

// MARK: - UITabBarControllerDelegate
extension AppDelegate: UITabBarControllerDelegate {
    
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if let splitViewController = window?.rootViewController as? UISplitViewController, splitViewController.viewControllers.count > 1 {
            splitViewController.viewControllers[1] = tabBarDetailControllers[tabBarController.selectedIndex]
        }
    }
    
}

// MARK: - UISplitViewControllerDelegate
extension AppDelegate: UISplitViewControllerDelegate {
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
}

