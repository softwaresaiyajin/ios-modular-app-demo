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

extension Specie: IEntity {
    public var el_id: String? { return id }
    public var el_name: String? { return name }
}

extension SpecieListAdapter: IRouteService {
    
    func el_navigate(to router: String, data: IEntity?) {
        Navigator.shared.navigate(id: Route.specieDetail,
                                  isAnimated: true,
                                  data: data)
    }
}

extension SpecieListAdapter: IDataService {
    
    func el_getItems() -> Observable<[IEntity]> {
        
        return DataManager.shared
            .fetch(endpoint: EndpointMap.speciesList)
            .map( { $0?.items ?? [] })
    }
}

extension SpecieListAdapter: IRepository {
    
    var el_routerService: IRouteService? { return self}
    
    var el_dataService: IDataService? { return self }

}
