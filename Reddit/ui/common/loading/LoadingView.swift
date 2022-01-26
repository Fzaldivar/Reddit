//
//  LoadingView.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 24/1/22.
//

import UIKit

class LoadingOverlay {

    // MARK: - Properties

    private var loadingView = LoadingView()
    static let shared = LoadingOverlay()

    private init() {}

    // MARK: - Utility methods

    func showOverlay(animated: Bool = true) {
        loadingView.clipsToBounds = true
        loadingView.alpha = 0

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let window = appDelegate.window else { return }

        loadingView.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
        window.addSubview(self.loadingView)

        guard animated else {
            loadingView.alpha = 1.0
            return
        }
        
        loadingView.configureView()
        animateView(showing: true, completion: nil)
    }

    func hideOverlayView(animated: Bool = true) {
        let completion = { [weak self] (_: Bool) in
            guard let self = self else { return }

            self.loadingView.removeFromSuperview()
        }

        animateView(showing: false, completion: completion)
    }

    private func animateView(showing: Bool, completion: ((Bool) -> Void)? = nil) {
        guard showing else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                UIView.transition(with: self.loadingView, duration: 0.2, options: [.transitionCrossDissolve], animations: {
                    self.loadingView.alpha = 0
                }, completion: completion)
            })

            return
        }

        UIView.transition(with: loadingView, duration: 0.2, options: [.transitionCrossDissolve], animations: {
            self.loadingView.alpha = 1.0
        }, completion: completion)
    }

}

private class LoadingView: UIView, NibLoadableView {

    // MARK: - Outlets

    @IBOutlet var loadingIndicator: UIActivityIndicatorView!

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        configureXib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureXib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureXib()
    }

    // MARK: - Utility methods

    func configureView() {
        loadingIndicator.color =  #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        loadingIndicator.startAnimating()
    }
}
