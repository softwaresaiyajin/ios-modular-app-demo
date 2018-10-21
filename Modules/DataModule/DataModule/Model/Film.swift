//
//  Film.swift
//  DataModule
//
//  Created by Gerald Adorza on 21/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation

public struct Film {
    
    public let id: String?
    public let title: String?
    public let detail: String?
    public let director: String?
    public let producer: String?
    public let releaseDate: String?
    public let rtScore: String?
}

extension Film: Codable {
    
    enum Identifier : String, CodingKey {
        case id
        case title
        case director
        case producer
        case detail = "description"
        case releaseDate = "release_date"
        case rtScore = "rt_score"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Identifier.self)
        try container.encodeIfPresent(detail, forKey: .detail)
        try container.encodeIfPresent(releaseDate, forKey: .releaseDate)
        try container.encodeIfPresent(rtScore, forKey: .rtScore)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(director, forKey: .director)
        try container.encodeIfPresent(producer, forKey: .producer)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Identifier.self)
        detail = try container.decodeIfPresent(String.self, forKey: .detail)
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        rtScore = try container.decodeIfPresent(String.self, forKey: .rtScore)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        producer = try container.decodeIfPresent(String.self, forKey: .producer)
        director = try container.decodeIfPresent(String.self, forKey: .director)
    }
}
