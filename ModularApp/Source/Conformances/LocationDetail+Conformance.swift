//
//  FilmDetail+Conformance.swift
//  ModularApp
//
//  Created by Gerald Adorza on 22/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation
import EntityDetailModule
import DataModule
import RxSwift
import Navigator

fileprivate struct MockFieldAdapter {
    var title: String?
    var value: String?
}

extension MockFieldAdapter: IEntityField {
    
    var ed_id: String? { return nil }
    var ed_title: String? { return title }
    var ed_detail: String? { return value }
}

extension Location {

    fileprivate var fields: [MockFieldAdapter] {
        return [
            MockFieldAdapter(title: "Name", value: name),
            MockFieldAdapter(title: "Climate", value: climate),
            MockFieldAdapter(title: "Terrain", value: terrain),
            MockFieldAdapter(title: "Surface Water", value: surfaceWater)
        ]
    }
}

extension LocationDetailAdapter: IDataService {
    
    func ed_getItems(id: String) -> Observable<[IEntityField]> {
        
        let parameters: [String: Any] = [
            ParameterKey.locationId: id
        ]
        
        return DataManager.shared
            .fetch(endpoint: EndpointMap.locationDetail, parameters: parameters)
            .map( { $0?.detail?.fields ?? [] })
    }
}

extension LocationDetailAdapter: IRouteService {
    
    func ed_navigate(to router: String, data: IEntityField?) {
        //DO NOTHING
    }
}

extension LocationDetailAdapter: IRepository {
    
    var ed_routerService: IRouteService? { return self }
    
    var ed_dataService: IDataService? { return self }
}
