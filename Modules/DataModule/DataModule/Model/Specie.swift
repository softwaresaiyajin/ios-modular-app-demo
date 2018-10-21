//
//  Specie.swift
//  DataModule
//
//  Created by Gerald Adorza on 21/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation

public struct Specie {
    
    public let id: String?
    public let name: String?
    public let classification: String?
    public let eyeColors: String?
    public let hairColors: String?
}

extension Specie: Codable {
    
    fileprivate enum Identifier: String, CodingKey {
        case id
        case name
        case classification
        case eyeColors = "eye_colors"
        case hairColors = "hair_colors"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Identifier.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        classification = try container.decode(String.self, forKey: .classification)
        eyeColors = try container.decode(String.self, forKey: .eyeColors)
        hairColors = try container.decode(String.self, forKey: .hairColors)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Identifier.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(classification, forKey: .classification)
        try container.encodeIfPresent(eyeColors, forKey: .eyeColors)
        try container.encodeIfPresent(hairColors, forKey: .hairColors)
    }
}
