//
//  UrlHelper.swift
//  DataModule
//
//  Created by Gerald Adorza on 21/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation

struct UrlHelper {
    
    static func getDynamicUrl<T>(
        rootUrl: String,
        endpoint: Endpoint<T>,
        parameters: [String: Any]?
        ) -> String {
        
        let fullUrl = "\(rootUrl)\(endpoint.url)"
    
        guard let args = parameters, args.count > 0 else {
            return fullUrl
        }
        
        let url = endpoint.pathParameterKeys
            .reduce(fullUrl) { (result, key) -> String in
                
                guard let value = args[key] as? String else { return result }
                return result.replacingOccurrences(of: key, with: value)
        }
        return url
    }
}
