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

extension Person {

    fileprivate var fields: [MockFieldAdapter] {
        return [
            MockFieldAdapter(title: "Name", value: name),
            MockFieldAdapter(title: "Gender", value: gender),
            MockFieldAdapter(title: "Age Group", value: ageGroup),
            MockFieldAdapter(title: "Eye Color", value: eyeColor),
            MockFieldAdapter(title: "Hair Color", value: hairColor)
        ]
    }
}

extension PersonDetailAdapter: IDataService {
    
    func ed_getItems(id: String) -> Observable<[IEntityField]> {
        
        let parameters: [String: Any] = [
            ParameterKey.filmId: id
        ]
        
        return DataManager.shared
            .fetch(endpoint: EndpointMap.personDetail, parameters: parameters)
            .map( { $0?.detail?.fields ?? [] })
    }
}

extension PersonDetailAdapter: IRouteService {
    
    func ed_navigate(to router: String, data: IEntityField?) {
        //DO NOTHING
    }
}

extension PersonDetailAdapter: IRepository {
    
    var ed_routerService: IRouteService? { return self }
    
    var ed_dataService: IDataService? { return self }
}
