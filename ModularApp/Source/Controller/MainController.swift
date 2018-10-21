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
import EntityListModule
import EntityDetailModule

fileprivate enum TabRoot: Int {
    
    case film
    case people
    case location
    case specie
    case vehicle
    
    var title: String {
        switch self {
        case .film: return "Film"
        case .people: return "People"
        case .location: return "Locations"
        case .specie: return "Species"
        case .vehicle: return "Vehicles"
        }
    }
    
    var controller: UIViewController {
        return EntityListViewController()
    }
    
    static let items: [TabRoot] = [.film, .people, .location, .specie, .vehicle]
}

fileprivate struct AppConfig {
    static let rootUrl = "https://ghibliapi.herokuapp.com"
}

class MainController {
    
    private(set) var window: UIWindow
    
    private var tabController: UITabBarController?
    
    private var selectedNavBarController: UINavigationController? {
        return tabController?.selectedViewController as? UINavigationController
    }
    
    private lazy var provider: AppProvider = {
        return AppProvider()
    }()
    
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
        dataProvider.startSession(rootUrl: AppConfig.rootUrl)
    }
    
    private func createTab(rootControllers: [TabRoot]) -> UITabBarController {

        let tabController = UITabBarController()
        tabController.viewControllers = rootControllers
            .enumerated()
            .map({ (pair) -> UINavigationController in
                let controller = pair.element.controller
                let title = pair.element.title
                let navigation = UINavigationController(rootViewController: controller)
                navigation.tabBarItem = UITabBarItem(title: title,
                                                     image: nil,
                                                     selectedImage: nil)
                controller.title = title
                return navigation
            })
        
        return tabController
    }

    private func setupRoutes() {
 
        let roots = TabRoot.items
        let tabController = createTab(rootControllers: roots)
        self.tabController = tabController
        
        func getRoot(tab: UITabBarController,
                     index: Int,
                     repository: EntityListModule.IRepository) -> EntityListViewController {
            guard let controllers = tab.viewControllers,
                index < controllers.count else { return EntityListViewController() }
            guard let nav = controllers[index] as? UINavigationController else { return EntityListViewController() }
            let controller = (nav.viewControllers[0] as? EntityListViewController) ?? EntityListViewController()
            controller.repository = repository
            return controller
        }
        
        let filmList = getRoot(tab: tabController,
                               index: TabRoot.film.rawValue,
                               repository: provider.filmListProvider)
        
        let personList = getRoot(tab: tabController,
                                 index: TabRoot.people.rawValue,
                                 repository: provider.personListProvider)
        
        let locationList = getRoot(tab: tabController,
                                   index: TabRoot.location.rawValue,
                                   repository: provider.locationListProvider)
        
        let specieList = getRoot(tab: tabController,
                                 index: TabRoot.specie.rawValue,
                                 repository: provider.specieListProvider)
        
        let vehicleList = getRoot(tab: tabController,
                                  index: TabRoot.vehicle.rawValue,
                                  repository: provider.vehicleListProvider)

        routeProvider
            
            .map(ids: Route.root, location: tabController) { [weak self] (event) in
                self?.window.rootViewController = event.destination
                self?.routeProvider.navigate(id: Route.filmList.first)
                
            }.map(ids: Route.filmList, location: filmList) { [weak self] (event) in
                event.destination.repository = self?.provider.filmListProvider
                
            }.map(ids: Route.personList, location: personList) { [weak self] (event) in
                event.destination.repository = self?.provider.personListProvider
                
            }.map(ids: Route.locationList, location: locationList) { [weak self] (event) in
                event.destination.repository = self?.provider.locationListProvider
                
            }.map(ids: Route.vehicleList, location: vehicleList) { [weak self] (event) in
                event.destination.repository = self?.provider.vehicleListProvider
                
            }.map(ids: Route.specieList, location: specieList) { [weak self] (event) in
                event.destination.repository = self?.provider.specieListProvider
                
            }.map(ids: Route.detail, location: EntityDetailViewController.self) {
                [weak self] (event) in
                
                guard let controller = event.destination else { return }
                
                if let data = event.data as? Film, let id = data.id {
                    controller.input = .basic(id, data.title)
                    controller.repository = self?.provider.filmDetailProvider
                    
                } else if let data = event.data as? Person, let id = data.id {
                    controller.input = .basic(id, data.name)
                    controller.repository = self?.provider.personDetailProvider
                    
                } else if let data = event.data as? Location, let id = data.id {
                    controller.input = .basic(id, data.name)
                    controller.repository = self?.provider.locationDetailProvider
                    
                } else if let data = event.data as? Specie, let id = data.id {
                    controller.input = .basic(id, data.name)
                    controller.repository = self?.provider.specieDetailProvider
                    
                } else if let data = event.data as? Vehicle, let id = data.id {
                    controller.input = .basic(id, data.name)
                    controller.repository = self?.provider.vehicleDetailProvider
                    
                }
                
                let nav = UINavigationController(rootViewController: controller)
                controller.configure()
                self?.selectedNavBarController?
                    .present(nav, animated: event.isAnimated, completion: nil)
        }
        
        
        
        
        routeProvider.navigate(id: Route.root.first)
    }
}
