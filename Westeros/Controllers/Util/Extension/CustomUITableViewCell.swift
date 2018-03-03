//
//  CustomUITableViewCell.swift
//  Westeros
//
//  Created by Brais Moure on 3/3/18.
//  Copyright © 2018 Brais Moure. All rights reserved.
//

import UIKit

extension UITableViewCell {

    // Personaliza una celda
    func westerosCellView() {
        textLabel?.font = UIFont.init(name: "Game of Thrones", size: 16.0)!
        imageView?.contentMode = .scaleAspectFit
        imageView?.clipsToBounds = true
    }
    
}
