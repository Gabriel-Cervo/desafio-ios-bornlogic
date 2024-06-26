//
//  SceneDelegate.swift
//  bornlogic-test
//
//  Created by João Gabriel Dourado Cervo on 11/05/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var appCoordinator: NavigationCoordinator?
    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        saveKeychainData()
        registerDependenciesToInject()
        
        guard let _ = (scene as? UIWindowScene) else { return }
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
    
    /// Saves to keychain pre-written data.
    private func saveKeychainData() {        
        KeychainHelper.shared.save(
            "be70cfced3ab49ccb08a80b0025f3bea",
            service: Constants.newsApiService,
            account: Constants.newsApiAccount
        )
    }

    private func registerDependenciesToInject() {
        guard let navigationController = window?.rootViewController as? UINavigationController else { return }
        
        let container = DIContainer()
        
        container.register(type: NavigationCoordinator.self) { container in
            AppCoordinator(navigationController: navigationController, container: container)
        }
        
        container.register(type: NewsCoordinatorProtocol.self) { container in
            NewsCoordinator(container: container, navigationController: navigationController)
        }
        
        container.register(type: NetworkServiceProtocol.self) { container in
            DefaultNetworkService()
        }
        
        appCoordinator = container.resolve(type: NavigationCoordinator.self)!
    }
}

