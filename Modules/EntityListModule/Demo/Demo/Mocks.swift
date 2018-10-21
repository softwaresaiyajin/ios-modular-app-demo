//
//  Mocks.swift
//  Demo
//
//  Created by Gerald Adorza on 21/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation
import EntityListModule
import RxSwift

public struct MockEntity {
    var name: String
    var id: String
}

extension MockEntity: IEntity {
    
    public var el_id: String? { return id }
    public var el_name: String? { return name }
}

public class AppProvider { }

extension AppProvider: IRouteService {
    
    public func el_navigate(to router: Route, data: IEntity) {
        
    }
}

extension AppProvider: IDataService {
    
    public func el_getItems() -> Observable<[IEntity]> {
        
        let data = [
            "Castle in the Sky",
            "Grave of the Fireflies"
        ]
        
        var items = [IEntity]()
        for idx in 0..<20 {
            let name = data[idx % data.count]
            let item = MockEntity(name: name, id: "\(idx)")
            items.append(item)
        }
        return Observable.just(items)
    }
}

extension AppProvider: IRepository {
    
    public var el_routerService: IRouteService? { return self }
    
    public var el_dataService: IDataService? { return self }
    
}
