//
//  FilmListMapper.swift
//  DataModule
//
//  Created by Gerald Adorza on 21/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation

public typealias FilmListMapper = ListMapper<Film>
public typealias PersonListMapper = ListMapper<Person>
public typealias LocationListMapper = ListMapper<Location>
public typealias SpecieListMapper = ListMapper<Specie>
public typealias VehicleListMapper = ListMapper<Vehicle>

public struct ListMapper<T: Codable> {
    
    public var items: [T]?
}

extension ListMapper: Codable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        items = try container.decode([T].self)
    }
    
    public func encode(to encoder: Encoder) throws {
   
    }
}
