//
//  UIView+Extension.swift
//  bornlogic-test
//
//  Created by João Gabriel Dourado Cervo on 11/05/24.
//

import UIKit

extension UIView {
    /// Starts a shimmering animation. This animation is used for showing 'skeleton' of the current content when loading.
    func startShimmeringAnimation(
        animationSpeed: Float = 1.4,
        repeatCount: Float = .greatestFiniteMagnitude
    ) {
        let blockView = UIView()
        blockView.tag = Constants.shimmeringBlockTag
        blockView.backgroundColor = AppColors.navigationBarBackground
        blockView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(blockView)
        
        NSLayoutConstraint.activate([
            blockView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blockView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blockView.topAnchor.constraint(equalTo: topAnchor),
            blockView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        let lightColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1).cgColor
        let blackColor = UIColor.black.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [blackColor, lightColor, blackColor]
        gradientLayer.frame = CGRect(x: -bounds.size.width, y: -bounds.size.height, width: 3 * bounds.size.width, height: 3 * bounds.size.height)
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.locations =  [0.35, 0.50, 0.65]
        
        layer.mask = gradientLayer
        
        CATransaction.begin()
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = CFTimeInterval(animationSpeed)
        animation.repeatCount = repeatCount
        
        CATransaction.setCompletionBlock { [weak self] in
            self?.layer.mask = nil
        }
        
        gradientLayer.add(animation, forKey: "shimmerAnimation")
        
        CATransaction.commit()
    }
    
    func stopShimmeringAnimation() {
        if let blockView = subviews.first(where: { $0.tag == Constants.shimmeringBlockTag }) {
            blockView.removeFromSuperview()
        }
        
        layer.mask = nil
    }
}
