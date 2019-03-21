//
//  MessagePostTableViewCell.swift
//  NewsFeed
//
//  Created by Roman Shveda on 3/18/19.
//  Copyright © 2019 Roman Shveda. All rights reserved.
//

import UIKit

final class MessagePostTVCell: BasicTVCell {
    
    @IBOutlet private weak var messageView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        postImage.layer.cornerRadius = postImage.bounds.height / 2
        postImage.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        messageView.text = ""
    }

    override func configure(with data: Post) {
        super.configure(with: data)
        messageView.text = data.message
    }
}
