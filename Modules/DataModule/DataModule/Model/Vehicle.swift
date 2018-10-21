//
//  Vehicle.swift
//  DataModule
//
//  Created by Gerald Adorza on 21/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation

public struct Vehicle {
    
    public let id: String?
    public let name: String?
    public let description: String?
    public let `class`: String?
    public let length: String?
}

extension Vehicle: Codable {
    
    fileprivate enum Identifier: String, CodingKey {
        case id
        case name
        case description
        case `class` = "vehicle_class"
        case length
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Identifier.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        self.class = try container.decode(String.self, forKey: .class)
        length = try container.decode(String.self, forKey: .length)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Identifier.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(self.class, forKey: .class)
        try container.encodeIfPresent(length, forKey: .length)
    }
}
