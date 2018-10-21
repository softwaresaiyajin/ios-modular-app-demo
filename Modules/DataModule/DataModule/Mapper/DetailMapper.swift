//
//  FilmDetailsMapper.swift
//  DataModule
//
//  Created by Gerald Adorza on 21/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation

public typealias FilmDetailMapper = DetailMapper<Film>
public typealias PersonDetailMapper = DetailMapper<Person>
public typealias LocationDetailMapper = DetailMapper<Location>
public typealias SpecieDetailMapper = DetailMapper<Specie>
public typealias VehicleDetailMapper = DetailMapper<Vehicle>

public struct DetailMapper<T: Codable> {
    
    public var detail: T?
}

extension DetailMapper: Codable {
    
    public init(from decoder: Decoder) throws {
        let container = try? decoder.singleValueContainer()
        detail = try container?.decode(T.self)
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}
