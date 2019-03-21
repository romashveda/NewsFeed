//
//  UIExtensions.swift
//  NewsFeed
//
//  Created by Roman Shveda on 3/19/19.
//  Copyright © 2019 Roman Shveda. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<T: BasicTVCell>(cellType: T.Type) {
        let nib = UINib(nibName: "\(T.self)", bundle: nil)
        let identifier = "\(cellType)"
        self.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func cell<T: BasicTVCell>(cellType: T.Type) -> T? {
        guard let cell = self.dequeueReusableCell(withIdentifier:"\(cellType)") as? T else {
            return nil
        }
        return cell
    }
}

extension UIImage {
    func resized(to width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
