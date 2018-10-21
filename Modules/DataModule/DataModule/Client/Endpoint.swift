//
//  Endpoint.swift
//  DataModule
//
//  Created by Gerald Adorza on 21/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation

public enum RestMethod {
    case get
    case post
}

public class Endpoint<T: Codable> {
    
    public private(set) var url: String
    
    public private(set) var method: RestMethod
    
    public private(set) var mapper: T.Type
    
    public private(set) var allowsResponseCaching: Bool
    
    private var _pathParameterKeys: [String] = []
    var pathParameterKeys: [String] { return _pathParameterKeys }
    
    init(url: String,
         method: RestMethod,
         mapper: T.Type,
         allowsResponseCaching: Bool = false) {
        
        self.url = url
        self.method = method
        self.mapper = mapper
        self.allowsResponseCaching = allowsResponseCaching
    }
    
    @discardableResult
    func addPathParameterKeys(_ keys: String...) -> Self {
        _pathParameterKeys.append(contentsOf: keys)
        return self
    }

}
