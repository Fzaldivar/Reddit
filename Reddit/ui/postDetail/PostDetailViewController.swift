//
//  PostDetailViewController.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 23/1/22.
//

import UIKit

class PostDetailViewController: UIViewController, StoryboardBased, View, Coordinated {

    // MARK: - Outlets
    
    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    
    // MARK: - Properties

    var coordinator: PostDetailCoordinator!
    var viewModel: PostDetailViewModel!
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    @IBAction func saveImage(_ sender: UIButton) {
        guard let image = postImageView.image else  { return }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc private func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        let alert = UIAlertController(title: viewModel.messageTitle, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: viewModel.buttonTitle, style: .default))
        self.present(alert, animated: true)
    }
    
    // MARK: - Configuration methods

    private func initialSetup() {
        titleLabel.text = viewModel.title
        postImageView.isHidden = !viewModel.imageUrl().isUrl()
        saveButton.isHidden = !viewModel.imageUrl().isUrl()
        
        if !postImageView.isHidden {
            postImageView.imageFromURL(urlString: viewModel.imageUrl())
        }
    }
}
