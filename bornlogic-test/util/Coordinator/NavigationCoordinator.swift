//
//  NavigationCoordinator.swift
//  bornlogic-test
//
//  Created by João Gabriel Dourado Cervo on 11/05/24.
//

import UIKit

protocol ExternalNavigationService {
    func openNewsViewController()
}

/// Represents a type that can coordinate the navigation between the screens
protocol NavigationCoordinator: ExternalNavigationService {
    var navigationController: UINavigationController { get set }
    var container: DIContainerService { get set }

    func popToRootViewController(animated: Bool)
}

//MARK: - Presentable View

/// Represents a type that can be presented in navigation
protocol PresentableView {
    func toPresent() -> UIViewController
}

extension PresentableView where Self: UIViewController {
    func toPresent() -> UIViewController {
        return self
    }
}

protocol PresentableNewsView: PresentableView {}
