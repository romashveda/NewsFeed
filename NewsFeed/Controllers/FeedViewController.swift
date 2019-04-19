//
//  ViewController.swift
//  NewsFeed
//
//  Created by Roman Shveda on 3/18/19.
//  Copyright © 2019 Roman Shveda. All rights reserved.
//

import UIKit

final class FeedViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        posts = ParsingManager.shared.getParsedData()
        switch sender.selectedSegmentIndex {
        case 1:
            posts = posts.filter({ $0.type == .messagePost })
        case 2:
            posts = posts.filter({ $0.type == .photoPost })
        default:
            break
        }
        tableView.reloadData()
    }
    
    private var posts: [Post] = ParsingManager.shared.getParsedData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cellType: MessagePostTVCell.self)
        tableView.register(cellType: PhotoPostTVCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }


}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        var cell: BasicTVCell!
        switch post.type {
        case .messagePost:
            cell = tableView.cell(cellType: MessagePostTVCell.self)
        case .photoPost:
            cell = tableView.cell(cellType: PhotoPostTVCell.self)
        }
        cell.configure(with: post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let post = posts[indexPath.row]
        switch post.type {
        case .photoPost:
            return 350
        default:
           return UITableView.automaticDimension
        }
    }
}

