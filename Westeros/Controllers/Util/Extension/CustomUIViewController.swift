//
//  CustomUIViewController.swift
//  Westeros
//
//  Created by Brais Moure on 3/3/18.
//  Copyright © 2018 Brais Moure. All rights reserved.
//

import UIKit

extension UIViewController {

    // MARK: - Button
    
    func customizeBackButtom () {
        let myBackButton:UIButton = UIButton(type: UIButtonType.custom)
        myBackButton.addTarget(self, action: #selector(pop(_:)), for: UIControlEvents.touchUpInside)
        myBackButton.setImage(UIImage(named: "back"), for: .normal)
        myBackButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        myBackButton.sizeToFit()
        let myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: myBackButton)
        self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
    }
    
    @objc func pop(_ sender: AnyObject) {
        
        if let _ = self.navigationController?.popViewController(animated: true) {
            // Se ha cerrado correctamente
        } else {
            if(self.navigationController?.parent == nil) {
                // HACK: Nos aseguramos que siempre se puede cerrar
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
}
