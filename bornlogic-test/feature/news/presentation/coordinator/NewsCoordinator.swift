//
//  NewsCoordinator.swift
//  bornlogic-test
//
//  Created by João Gabriel Dourado Cervo on 12/05/24.
//

import UIKit

protocol NewsCoordinatorProtocol {
    var container: DIContainerService { get set }
    var navigationController: UINavigationController? { get set }
    
    func openNewsList()
    func openNews(article: NewsArticle)
}

//MARK: - implementation

class NewsCoordinator: NewsCoordinatorProtocol {
    var container: DIContainerService
    var navigationController: UINavigationController?
    
    init(container: DIContainerService,
                navigationController: UINavigationController? = nil) {
        self.container = container
        self.navigationController = navigationController
        registerDependencies()
    }
    
    private func registerDependencies() {
        registerRepositories()
        registerUseCases()
        registerViewModels()
        registerViewControllers()
    }
    
    private func registerRepositories() {
        container.register(type: NewsRepositoryProtocol.self) { container in
            DefaultNewsRepository(networkService: container.resolve(type: NetworkServiceProtocol.self)!)
        }
    }
    
    private func registerUseCases() {
        container.register(type: LoadNewsUseCase.self) { container in
            DefaultLoadNewsUseCase(repository: container.resolve(type: NewsRepositoryProtocol.self)!)
        }
    }
    
    private func registerViewModels() {
        container.register(type: NewsViewModelProtocol.self) { container in
            DefaultNewsViewModel(fetchDataUseCase: container.resolve(type: LoadNewsUseCase.self)!)
        }
    }
    
    private func registerViewControllers() {
        container.register(type: PresentableNewsView.self) { container in
            NewsViewController(
                coordinator: container.resolve(type: NewsCoordinatorProtocol.self)!,
                viewModel: container.resolve(type: NewsViewModelProtocol.self)!
            )
        }
    }
    
    func openNewsList() {
        let viewController = container.resolve(type: PresentableNewsView.self)!.toPresent()
        viewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(viewController, animated: false)
    }
    
    func openNews(article: NewsArticle) {
        
    }
}
