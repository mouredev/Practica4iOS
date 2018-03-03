//
//  UIViewController+Additions.swift
//  Westeros
//
//  Created by Brais Moure on 13/2/18.
//  Copyright © 2018 Brais Moure. All rights reserved.
//

import UIKit

extension UIViewController {
    func wrappedInNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}
