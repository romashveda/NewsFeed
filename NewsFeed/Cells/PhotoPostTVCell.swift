//
//  PhotoPostTableViewCell.swift
//  NewsFeed
//
//  Created by Roman Shveda on 3/18/19.
//  Copyright © 2019 Roman Shveda. All rights reserved.
//

import UIKit

final class PhotoPostTVCell: BasicTVCell {
    
    @IBOutlet private weak var likesCountLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        likesCountLabel.text = nil
    }
    
    override func configure(with data: Post) {
        super.configure(with: data)
        likesCountLabel.text = "❤️ " + "\(data.commentsCount)"
    }
}
