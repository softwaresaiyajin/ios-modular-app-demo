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
import Navigator
import RxSwift

extension Film: IEntity {
    public var el_id: String? { return id }
    public var el_name: String? { return title }
}

extension FilmListAdapter: IRouteService {
    
    func el_navigate(to router: String, data: IEntity?) {
        Navigator.shared.navigate(id: Route.filmDetail,
                                  isAnimated: true,
                                  data: data)
    }
}

extension FilmListAdapter: IDataService {
    
    func el_getItems() -> Observable<[IEntity]> {
        
        return DataManager.shared
            .fetch(endpoint: EndpointMap.filmList)
            .map( { $0?.items ?? [] })
    }
}

extension FilmListAdapter: IRepository {
    
    var el_routerService: IRouteService? { return self}
    
    var el_dataService: IDataService? { return self }

}
