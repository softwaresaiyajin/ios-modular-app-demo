//
//  ViewController+Extensions.swift
//  ModularApp
//
//  Created by Gerald Adorza on 22/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation
import UIKit
import EntityDetailModule

extension UIViewController {
    
    @objc func configure() {
        
    }
}

extension EntityDetailViewController {
    
    override func configure() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Dismiss",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(dismissDetail))
    }
    
    @objc private func dismissDetail() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}


