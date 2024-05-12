//
//  ArticleDetailsViewController.swift
//  bornlogic-test
//
//  Created by João Gabriel Dourado Cervo on 12/05/24.
//

import UIKit

class ArticleDetailsViewController: UIViewController {

    struct ArticleConstants {
        static let imageProportion: CGFloat = 0.5586
    }
    
    //MARK: - properties
    
    private let article: NewsArticle
    
    //MARK: - views
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private let scrollViewContentStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = Constants.defaultPadding
        return view
    }()
    
    private let topContentStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = Constants.defaultPadding / 2
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.numberOfLines = .zero
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = .zero
        label.textColor = AppColors.subtitleTextColor
        return label
    }()
    
    private let publishDateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = AppColors.footnoteTextColor
        return label
    }()
    
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray2
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var checkNewsButton: UIButton = {
        let button = UIButton(configuration: .filled(), primaryAction: .init(handler: { [unowned self] _ in
            self.didTapCheckNews()
        }))
        button.setTitle("Read the full article", for: .normal)
        return button
    }()
    
    //MARK: - setup
    
    init(article: NewsArticle) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Detalhes"
    }
    
    private func prepareView() {
        view.backgroundColor = .systemBackground
        prepareScrollView()
        prepareContentView()
    }
    
    private func prepareScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContentStack)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.defaultPadding),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.defaultPadding),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.defaultPadding),
            
            scrollViewContentStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollViewContentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollViewContentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func prepareContentView() {
        prepareTopContentStack()
        scrollViewContentStack.addArrangedSubview(divider)
        prepareImageView()
        prepareContentLabel()
        prepareCheckNewsButton()
    }
    
    private func prepareTopContentStack() {
        scrollViewContentStack.addArrangedSubview(topContentStack)

        topContentStack.addArrangedSubview(titleLabel)
        topContentStack.addArrangedSubview(subtitleLabel)
        topContentStack.addArrangedSubview(publishDateLabel)
        
        titleLabel.text = article.title
        subtitleLabel.text = article.description
        publishDateLabel.text = "\((article.publishedAt).asDate()) - \(article.source?.name ?? "")"
    }
    
    private func prepareImageView() {
        guard !article.urlToImage.isEmpty else {
            return
        }
        
        scrollViewContentStack.addArrangedSubview(newsImageView)
        newsImageView.kf.setImage(with: URL(string: article.urlToImage))

        newsImageView.heightAnchor.constraint(equalTo: scrollViewContentStack.widthAnchor, multiplier: ArticleConstants.imageProportion).isActive = true
    }
    
    private func prepareContentLabel() {
        scrollViewContentStack.addArrangedSubview(contentLabel)
        contentLabel.text = article.content
    }
    
    private func prepareCheckNewsButton() {
        guard !article.url.isEmpty else {
            return
        }
        
        scrollViewContentStack.addArrangedSubview(checkNewsButton)

    }
    
    private func didTapCheckNews() {
        guard let url = URL(string: article.url) else {
            return
        }
        
        UIApplication.shared.open(url)
    }
}
