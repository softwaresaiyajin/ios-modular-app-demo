//
//  Person.swift
//  DataModule
//
//  Created by Gerald Adorza on 21/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation

public struct Person {
    
    public let id: String?
    public let name: String?
    public let gender: String?
    public let ageGroup: String?
    public let eyeColor: String?
    public let hairColor: String?
}

extension Person: Codable {
    
    fileprivate enum Identifier: String, CodingKey {
        case id
        case name
        case gender
        case age
        case eyeColor = "eye_color"
        case hairColor = "hair_color"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Identifier.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        gender = try container.decode(String.self, forKey: .gender)
        ageGroup = try container.decode(String.self, forKey: .age)
        eyeColor = try container.decode(String.self, forKey: .eyeColor)
        hairColor = try container.decode(String.self, forKey: .hairColor)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Identifier.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(gender, forKey: .gender)
        try container.encodeIfPresent(ageGroup, forKey: .age)
        try container.encodeIfPresent(eyeColor, forKey: .eyeColor)
        try container.encodeIfPresent(hairColor, forKey: .hairColor)
    }
}
