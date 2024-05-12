//
//  AppCoordinator.swift
//  bornlogic-test
//
//  Created by João Gabriel Dourado Cervo on 11/05/24.
//

import UIKit

class AppCoordinator: NavigationCoordinator, ExternalNavigationService {
    var navigationController: UINavigationController
    var container: DIContainerService
               
    init(navigationController: UINavigationController, container: DIContainerService) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func openNewsViewController() {
        let newsCoordinator = container.resolve(type: NewsCoordinatorProtocol.self)!
        newsCoordinator.openNewsList()
    }
    
    func popToRootViewController(animated: Bool) {
        navigationController.popToRootViewController(animated: animated)
    }

}
