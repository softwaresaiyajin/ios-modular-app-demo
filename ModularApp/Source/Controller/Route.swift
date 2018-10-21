//
//  Route.swift
//  ModularApp
//
//  Created by Gerald Adorza on 21/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation
import DataModule
import EntityListModule

public struct Route {
    
    static let root = ["/root"]
    static let filmList = [getActualListUrl(type: Film.self)]
    static let personList = [getActualListUrl(type: Person.self)]
    static let locationList = [getActualListUrl(type: Location.self)]
    static let specieList = [getActualListUrl(type: Specie.self)]
    static let vehicleList = [getActualListUrl(type: Vehicle.self)]
    
    static let filmDetail = getActualDetailUrl(type: Film.self)
    static let personDetail = getActualDetailUrl(type: Person.self)
    static let locationDetail = getActualDetailUrl(type: Location.self)
    static let specieDetail = getActualDetailUrl(type: Specie.self)
    static let vehicleDetail = getActualDetailUrl(type: Vehicle.self)
    static let detail = [Route.filmDetail,
                         Route.personDetail,
                         Route.locationDetail,
                         Route.specieDetail,
                         Route.vehicleDetail]
}

extension Route {
    
    fileprivate static func getActualDetailUrl<T>(type: T.Type) -> String {
        return getActualUrl(base: EntityListModule.Route.detail, type: type)
    }
    
    fileprivate static func getActualListUrl<T>(type: T.Type) -> String {
        return getActualUrl(base: "el_list", type: type)
    }
    
    fileprivate static func getActualUrl<T>(base: String, type: T.Type) -> String {
        var name: String?
        if type == Film.self { name = "Film"}
        else if type == Person.self { name = "Person"}
        else if type == Location.self { name = "Location"}
        else if type == Specie.self { name = "Specie"}
        else if type == Vehicle.self { name = "Vehicle"}
        guard let value = name else { return base }
        return "\(base)_\(value)"
    }
}
