//
//  AppNavigation.swift
//  bornlogic-test
//
//  Created by João Gabriel Dourado Cervo on 11/05/24.
//

import UIKit

class AppNavigation: NavigationCoordinator, ExternalNavigationService {
    var navigationController: UINavigationController
    var container: DIContainerService
               
    init(navigationController: UINavigationController, container: DIContainerService) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func openNewsViewController() {
        //TODO: - news
    }
    
    func popToRootViewController(animated: Bool) {
        navigationController.popToRootViewController(animated: animated)
    }

}
