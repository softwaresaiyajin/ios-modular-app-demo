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

extension Vehicle: IEntity {
    public var el_id: String? { return id }
    public var el_name: String? { return name }
}

extension VehicleListAdapter: IRouteService {
    
    func el_navigate(to router: String, data: IEntity?) {
        Navigator.shared.navigate(id: Route.vehicleDetail,
                                  isAnimated: true,
                                  data: data)
    }
}

extension VehicleListAdapter: IDataService {
    
    func el_getItems() -> Observable<[IEntity]> {
        
        return DataManager.shared
            .fetch(endpoint: EndpointMap.vehicleList)
            .map( { $0?.items ?? [] })
    }
}

extension VehicleListAdapter: IRepository {
    
    var el_routerService: IRouteService? { return self}
    
    var el_dataService: IDataService? { return self }

}
