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

/// Represents a type that can be presented as the entry point for a navigation
protocol PresentableView {
    func toPresent() -> UIViewController
}

extension PresentableView where Self: UIViewController {
    func toPresent() -> UIViewController {
        return self
    }
}

/// A typat that is the entry point for the `News` feature's navigation
protocol PresentableNewsView: PresentableView {}
