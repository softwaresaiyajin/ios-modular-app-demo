//
//  FilmList+Conformance.swift
//  ModularApp
//
//  Created by Gerald Adorza on 21/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation
import EntityListModule
import DataModule
import RxSwift
import Navigator

extension Location: IEntity {
    public var el_id: String? { return id }
    public var el_name: String? { return name }
}

extension LocationListAdapter: IRouteService {
    
    func el_navigate(to router: String, data: IEntity?) {
        Navigator.shared.navigate(id: Route.locationDetail,
                                  isAnimated: true,
                                  data: data)
    }
}

extension LocationListAdapter: IDataService {
    
    func el_getItems() -> Observable<[IEntity]> {
        
        return DataManager.shared
            .fetch(endpoint: EndpointMap.locationList)
            .map( { $0?.items ?? [] })
    }
}

extension LocationListAdapter: IRepository {
    
    var el_routerService: IRouteService? { return self}
    
    var el_dataService: IDataService? { return self }

}
