//
//  BasicTableViewCell.swift
//  NewsFeed
//
//  Created by Roman Shveda on 3/18/19.
//  Copyright © 2019 Roman Shveda. All rights reserved.
//

import UIKit

class BasicTVCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        postImage.image = UIImage(named: "placeholder")
        postImage.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImage.image = UIImage(named: "placeholder")
        userNameLabel.text = nil
        commentsCountLabel.text = nil
        dateLabel.text = nil
    }
    
    func configure(with data: Post) {
//        setImage(data.imageURL)
        userNameLabel.text = data.userName
        commentsCountLabel.text = "💬 " + "\(data.commentsCount)"
        dateLabel.text = format(date: data.dateCreated)
    }
    
    func setImage(_ urlString: String, completion: ((_:UIImage?) -> ())?) {
        guard let imageName = urlString.components(separatedBy: "/").last, let url = URL(string: urlString) else { return }
        ImageManager.getImage(imageName, for: url) { [weak self] image in
//            self?.postImage.image = image
            completion?(image)
        }
    }
    
    private func format(date: Date) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMM dd, hh:mm"
        return dateFormat.string(from: date)
    }
}
