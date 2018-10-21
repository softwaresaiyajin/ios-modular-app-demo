//
//  IEntity.swift
//  EntityListModule
//
//  Created by Gerald Adorza on 21/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation

public protocol IEntityField {
    
    var ed_id: String? { get }
    
    var ed_title: String? { get }
    
    var ed_detail: String? { get }
}

