//
//  NewsListCell.swift
//  bornlogic-test
//
//  Created by João Gabriel Dourado Cervo on 12/05/24.
//

import UIKit
import Kingfisher

class NewsListCell: UITableViewCell {
    static let identifier = "NewListCell"
    
    struct NewsListCellConstants {
        static let imageProportion: CGFloat = 0.5586
    }

    //MARK: - properties
    
    private(set) var item: NewsArticle!
    
    //MARK: - views
    
    let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title3)
        label.numberOfLines = 2
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 3
        label.textColor = AppColors.subtitleTextColor
        return label
    }()
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private let publishDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = AppColors.footnoteTextColor
        return label
    }()
    
    private lazy var imageViewHeight = newsImageView.heightAnchor.constraint(equalTo: newsImageView.widthAnchor, multiplier: NewsListCellConstants.imageProportion)
    
    //MARK: - setup
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepareView()
    }
    
    private func prepareView() {
        addSubview(container)
        
        container.addSubview(titleLabel)
        container.addSubview(subtitleLabel)
        container.addSubview(newsImageView)
        container.addSubview(publishDateLabel)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),

            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: Constants.defaultPadding),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: Constants.defaultPadding),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -Constants.defaultPadding),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.defaultPadding / 2),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            newsImageView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: Constants.defaultPadding / 2),
            newsImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            imageViewHeight,
            
            publishDateLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: Constants.defaultPadding / 2),
            publishDateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            publishDateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            publishDateLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -Constants.defaultPadding)
        ])
    }
    
    func prepare(article: NewsArticle) {
        self.item = article
        
        titleLabel.text = article.title
        subtitleLabel.text = article.description
        newsImageView.kf.setImage(with: URL(string: article.urlToImage))
        publishDateLabel.text = "\(article.publishedAt.asDate()) - \(article.source?.name ?? "")"
        imageViewHeight.isActive = !article.urlToImage.isEmpty
        hideShimmerAnimation()
    }
    
    func showShimmerAnimation() {
        titleLabel.text = "Título da noticia, que pode ser bem longo, e geralmente é"
        subtitleLabel.text = "Descrição breve da notícia que pode ter até tres linhas geralmente"
        publishDateLabel.text = "data - autor"
        
        DispatchQueue.main.async { [weak self] in
            self?.titleLabel.startShimmeringAnimation()
            self?.subtitleLabel.startShimmeringAnimation()
            self?.publishDateLabel.startShimmeringAnimation()
            self?.newsImageView.startShimmeringAnimation()
        }
    }
    
    func hideShimmerAnimation() {
        titleLabel.stopShimmeringAnimation()
        subtitleLabel.stopShimmeringAnimation()
        publishDateLabel.stopShimmeringAnimation()
        
        DispatchQueue.main.async { [weak self] in
            self?.titleLabel.stopShimmeringAnimation()
            self?.subtitleLabel.stopShimmeringAnimation()
            self?.publishDateLabel.stopShimmeringAnimation()
            self?.newsImageView.stopShimmeringAnimation()
        }
    }
}
