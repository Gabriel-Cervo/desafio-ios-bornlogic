//
//  NewsViewController.swift
//  bornlogic-test
//
//  Created by João Gabriel Dourado Cervo on 12/05/24.
//

import UIKit

class NewsViewController: UIViewController, PresentableNewsView {
    
    //MARK: - properties
    
    private let coordinator: NewsCoordinatorProtocol
    private let viewModel: NewsViewModelProtocol
    private var currentPage = 1
    
    //MARK: - views
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .init(top: Constants.defaultPadding, left: .zero, bottom: Constants.defaultPadding, right: .zero)
        tableView.register(NewsListCell.self, forCellReuseIdentifier: NewsListCell.identifier)
        tableView.refreshControl = refreshControl
        tableView.backgroundColor = .systemBackground
        if #available(iOS 15.0, *) { tableView.sectionHeaderTopPadding = 0 }
        return tableView
    }()
    
    private let refreshControl = UIRefreshControl()
    
    //MARK: - setup
    
    init(coordinator: NewsCoordinatorProtocol, viewModel: NewsViewModelProtocol) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        
        viewModel.onFetchError = {
            print("[ERROR]:: \($0)")
        }
        
        viewModel.onFetchSuccess = { [weak self] _ in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                self?.tableView.reloadData()
            }
        }
        
        viewModel.fetchData(forPage: currentPage)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.title = "DailyNews"
        title = "DailyNews"
        navigationItem.hidesBackButton = true
    }
    
    private func prepareView() {
        view.backgroundColor = .systemBackground
        prepareTableView()
        
        refreshControl.addTarget(self, action: #selector(didPullRefresh), for: .valueChanged)
    }
    
    private func prepareTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc 
    private func didPullRefresh() {
        tableView.visibleCells.forEach {
            guard let cell = $0 as? NewsListCell else { return }
            cell.showShimmerAnimation()
        }
        
        currentPage = 1
        viewModel.fetchData(forPage: currentPage)
    }
}

//MARK: - table view delegate & data source

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let news = viewModel.news else { return 5 }
        return news.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsListCell.identifier, for: indexPath) as? NewsListCell else { return UITableViewCell() }
        
        if let listData = viewModel.news {
            cell.prepare(article: listData.articles[indexPath.row])
        } else {
            cell.showShimmerAnimation()
        }
        
        cell.selectionStyle = .none
        return cell
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let news = viewModel.news else { return }
        coordinator.openNews(article: news.articles[indexPath.row])
    }
}
