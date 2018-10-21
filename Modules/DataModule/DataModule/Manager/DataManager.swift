//
//  DataManager.swift
//  DataModule
//
//  Created by Gerald Adorza on 21/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation
import RxSwift

public class DataManager {
    
    public private(set) var rootUrl: String = ""
    
    public static let shared = DataManager()
    
    private init() {
        
    }
    
    public func startSession(rootUrl: String) {
        self.rootUrl = rootUrl
    }
    
    public func endSession() {
    
    }
    
    public func fetch<T>(endpoint: Endpoint<T>,
                         parameters: [String: Any]? = nil) -> Observable<T?> {
        let request = Request(rootUrl: rootUrl,
                              endpoint: endpoint,
                              parameters: parameters)
        return request.send()
    }
}
