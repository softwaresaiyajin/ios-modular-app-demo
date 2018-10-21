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
    var ed_title: String? { return title}
    var ed_detail: String? { return value }
}

extension Vehicle {
    
    fileprivate var fields: [MockFieldAdapter] {
        return [
            MockFieldAdapter(title: "Name", value: name),
            MockFieldAdapter(title: "Description", value: description),
            MockFieldAdapter(title: "Class", value: `class`),
            MockFieldAdapter(title: "Length", value: length)
        ]
    }
}

extension VehicleDetailAdapter: IDataService {
    
    func ed_getItems(id: String) -> Observable<[IEntityField]> {
        
        let parameters: [String: Any] = [
            ParameterKey.vehicleId: id
        ]
        
        return DataManager.shared
            .fetch(endpoint: EndpointMap.vehicleDetail, parameters: parameters)
            .map( { $0?.detail?.fields ?? [] })
    }
}

extension VehicleDetailAdapter: IRouteService {
    
    func ed_navigate(to router: String, data: IEntityField?) {
        //DO NOTHING
    }
}

extension VehicleDetailAdapter: IRepository {
    
    var ed_routerService: IRouteService? { return self }
    
    var ed_dataService: IDataService? { return self }
}
