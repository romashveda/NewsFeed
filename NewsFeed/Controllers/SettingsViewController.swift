//
//  SettingsViewController.swift
//  NewsFeed
//
//  Created by Roman Shveda on 3/20/19.
//  Copyright © 2019 Roman Shveda. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    @IBOutlet private weak var countSlider: UISlider!
    @IBOutlet private weak var memorySlider: UISlider!
    @IBOutlet private weak var countLimitLabel: UILabel!
    @IBOutlet private weak var memoryLimitLabel: UILabel!
    
    private let countLimit = CacheManager.shared.countLimit
    private let memoryLimit = CacheManager.shared.memoryLimit

    @IBAction func countLimitChanged(_ sender: UISlider) {
        countLimitLabel.text = "\(Int(sender.value))"
        CacheManager.shared.countLimit = Int(sender.value)
    }
    
    @IBAction func memoryLimitChanged(_ sender: UISlider) {
        memoryLimitLabel.text = "\(Int(sender.value))"
        CacheManager.shared.memoryLimit = Int(sender.value)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        countSlider.value = Float(countLimit)
        memorySlider.value = Float(memoryLimit)
        countLimitLabel.text = "\(countLimit)"
        memoryLimitLabel.text = "\(memoryLimit)"
    }
}
