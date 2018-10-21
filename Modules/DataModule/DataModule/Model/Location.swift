//
//  Location.swift
//  DataModule
//
//  Created by Gerald Adorza on 21/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation

public struct Location {
    
    public let id: String?
    public let name: String?
    public let climate: String?
    public let terrain: String?
    public let surfaceWater: String?
}

extension Location: Codable {
    
    fileprivate enum Identifier: String, CodingKey {
        case id
        case name
        case climate
        case terrain
        case surfaceWater = "surface_water"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Identifier.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        climate = try container.decode(String.self, forKey: .climate)
        terrain = try container.decode(String.self, forKey: .terrain)
        surfaceWater = try container.decode(String.self, forKey: .surfaceWater)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Identifier.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(climate, forKey: .climate)
        try container.encodeIfPresent(terrain, forKey: .terrain)
        try container.encodeIfPresent(surfaceWater, forKey: .surfaceWater)
    }
}
