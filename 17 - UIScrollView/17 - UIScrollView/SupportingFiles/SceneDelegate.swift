//
//  SceneDelegate.swift
//  17 - UIScrollView
//
//  Created by Владимир Осипов on 28.05.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

//MARK: создаём NavigationController и TabBarController
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScreen = (scene as? UIWindowScene) else { return }
         
        let buyVC = BuyViewController()
        let forYouVC = ForYouViewController()
        let searchVC = SearchViewController()
        let cartVC = CartViewController()
        let tabBarVC = UITabBarController()
        //прописываем это здесь, чтобы barItem сразу появился при загрузке
        buyVC.tabBarItem = UITabBarItem(title: "Купить", image: .checkmark, selectedImage: .add)
        forYouVC.tabBarItem = UITabBarItem(title: "Для вас", image: .checkmark, selectedImage: .add)
        searchVC.tabBarItem = UITabBarItem(title: "Поиск", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        cartVC.tabBarItem = UITabBarItem(title: "Корзина", image: .checkmark, selectedImage: .add)
        
        tabBarVC.setViewControllers([buyVC, forYouVC, searchVC, cartVC], animated: true)
        tabBarVC.tabBar.backgroundColor = model.backgroundColorForObjects
        tabBarVC.tabBar.tintColor = model.tintColorForButtons
        tabBarVC.tabBar.unselectedItemTintColor = .lightGray
        
        let navController = UINavigationController(rootViewController: tabBarVC)
        
        window = UIWindow(windowScene: windowScreen)
        window?.rootViewController = navController
        window?.backgroundColor = .black
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

