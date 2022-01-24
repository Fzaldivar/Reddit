//
//  UIImageView+Downloader.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 23/1/22.
//

import UIKit
import Nuke

extension UIImageView {

    func imageFromURL(urlString: String) {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        Nuke.loadImage(with: urlString, into: self) { _ in
            DispatchQueue.main.async {
                activityIndicator.removeFromSuperview()
            }
        }
    }
}
