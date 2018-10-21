//
//  PersonDetailMapper.swift
//  DataModule
//
//  Created by Gerald Adorza on 21/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation

public struct PersonDetailMapper {
    
    public var detail: Person?
}

extension PersonDetailMapper: Codable {
    
    public init(from decoder: Decoder) throws {
        let container = try? decoder.singleValueContainer()
        detail = try container?.decode(Person.self)
    }
    
    public func encode(to encoder: Encoder) throws {
        
    }
}
