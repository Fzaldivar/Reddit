//
//  PostTableViewCell.swift
//  Reddit
//
//  Created by Fernando Zaldivar on 23/1/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var commentsLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var isReadLabel: UILabel!
    
    // MARK: - Properties
    
    private var viewModel: PostTableViewCellViewModel!

    // MARK: - Lifecyle methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Configuration methods

    func configureCell(_ viewModel: PostTableViewCellViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title()
        authorLabel.text = "Author: \(viewModel.author())"
        commentsLabel.text = "\(viewModel.comments()) comments"
        timeLabel.text = "\(hoursDifference(viewModel.created())) hours ago"
        updateReadStatus()
        
        if viewModel.thumbnail().isUrl() {
            postImageView.imageFromURL(urlString: viewModel.thumbnail())
        } else {
            postImageView.image = nil
        }
    }
    
    func updateReadStatus() {
        isReadLabel.text = viewModel.isPostRead() ? "Read" : "Unread"
        isReadLabel.textColor = viewModel.isPostRead() ? .systemGreen : .red
    }
    
    private func hoursDifference(_ time: Int)  -> Int {
        let epochTime = TimeInterval(viewModel.created())
        let diff = Int(Date().timeIntervalSince1970 - Date(timeIntervalSince1970: epochTime).timeIntervalSince1970)
        return Int(round(Double(diff) / 3600))
    }
}
