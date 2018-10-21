//
//  MainController.swift
//  ModularApp
//
//  Created by Gerald Adorza on 21/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation
import UIKit
import DataModule
import Navigator

class MainController {
    
    private(set) var window: UIWindow
    
    private lazy var dataProvider: DataManager = {
        return DataManager.shared
    }()
    
    private lazy var routeProvider: Navigator = {
        return Navigator.shared
    }()
    
    static func launch(window: UIWindow) -> MainController {
        return MainController(window: window)
    }
    
    private init(window: UIWindow) {
        self.window = window
        setupDataLayer()
        setupRoutes()
    }
    
    private func setupDataLayer() {
        dataProvider.startSession()
    }
    
    private func setupRoutes() {
 
    }
}
