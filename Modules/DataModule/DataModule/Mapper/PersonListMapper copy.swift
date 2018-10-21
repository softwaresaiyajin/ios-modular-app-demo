//
//  PersonListMapper.swift
//  DataModule
//
//  Created by Gerald Adorza on 21/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation

public struct PersonListMapper {
    
    public var items: [Person]?
}

extension PersonListMapper: Codable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        items = try container.decode([Person].self)
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}
