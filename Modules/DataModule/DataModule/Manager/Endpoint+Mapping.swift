//
//  Service.swift
//  DataModule
//
//  Created by Gerald Adorza on 21/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation

public struct ParameterKey {
    public static let filmId = "{filmId}"
    public static let personId = "{personId}"
    public static let locationId = "{locationId}"
    public static let specieId = "{specieId}"
    public static let vehicleId = "{vehicleId}"
}

public struct EndpointMap {
    
    fileprivate static func addEndpoint<T: Codable>(
        url: String,
        method: RestMethod,
        mapper: T.Type,
        allowsResponseCaching: Bool = false) -> Endpoint<T> {
        return Endpoint(url: url,
                        method: method,
                        mapper: mapper,
                        allowsResponseCaching: allowsResponseCaching)
    }
    
    public static let filmList = addEndpoint(
        url: "/films",
        method: .get,
        mapper: FilmListMapper.self
    )
    
    public static let filmDetail = addEndpoint(
        url: "/films/\(ParameterKey.filmId)",
        method: .get,
        mapper: FilmDetailMapper.self
        ).addPathParameterKeys(ParameterKey.filmId)
    
    public static let personList = addEndpoint(
        url: "/people",
        method: .get,
        mapper: PersonListMapper.self
    )
    
    public static let personDetail = addEndpoint(
        url: "/people/\(ParameterKey.personId)",
        method: .get,
        mapper: PersonDetailMapper.self
        ).addPathParameterKeys(ParameterKey.personId)
    
    public static let locationList = addEndpoint(
        url: "/locations",
        method: .get,
        mapper: LocationListMapper.self
    )
    
    public static let locationDetail = addEndpoint(
        url: "/locations/\(ParameterKey.locationId)",
        method: .get,
        mapper: LocationDetailMapper.self
        ).addPathParameterKeys(ParameterKey.locationId)
    
    public static let speciesList = addEndpoint(
        url: "/species",
        method: .get,
        mapper: SpecieListMapper.self
    )
    
    public static let specieDetail = addEndpoint(
        url: "/species/\(ParameterKey.specieId)",
        method: .get,
        mapper: SpecieDetailMapper.self
        ).addPathParameterKeys(ParameterKey.specieId)
    
    public static let vehicleList = addEndpoint(
        url: "/vehicles",
        method: .get,
        mapper: VehicleListMapper.self
    )
    
    public static let vehicleDetail = addEndpoint(
        url: "/vehicles/\(ParameterKey.vehicleId)",
        method: .get,
        mapper: VehicleListMapper.self
        ).addPathParameterKeys(ParameterKey.vehicleId)
}

