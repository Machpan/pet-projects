//
//  SceneDelegate.swift
//  e-shop
//
//  Created by Владимир Осипов on 28.05.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

//MARK: создаём NavigationController и TabBarController
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScreen = (scene as? UIWindowScene) else { return }
         
        let searchVC = SearchViewController()
        let buyVC = BuyViewController()
        let forYouVC = ForYouViewController()
        let cartVC = CartViewController()
        let tabBarVC = UITabBarController()
        //прописываем это здесь, чтобы barItem сразу появился при загрузке
        searchVC.tabBarItem = UITabBarItem(title: "Поиск", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        buyVC.tabBarItem = UITabBarItem(title: "Купить", image: .checkmark, selectedImage: .add)
        forYouVC.tabBarItem = UITabBarItem(title: "Для вас", image: .checkmark, selectedImage: .add)
        cartVC.tabBarItem = UITabBarItem(title: "Корзина", image: .checkmark, selectedImage: .add)
        tabBarVC.setViewControllers([searchVC, buyVC, forYouVC, cartVC], animated: true)
        tabBarVC.tabBar.backgroundColor = UIColor(red: 0.07, green: 0.09, blue: 0.1, alpha: 1)
        tabBarVC.tabBar.tintColor = UIColor(red: 0.37, green: 0.78, blue: 0.9, alpha: 1)
        tabBarVC.tabBar.unselectedItemTintColor = .lightGray
        
        let navController = UINavigationController(rootViewController: tabBarVC)
        
        window = UIWindow(windowScene: windowScreen)
        window?.rootViewController = navController
        window?.backgroundColor = .black
        window?.makeKeyAndVisible()
    }
}

