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

extension Film {

    fileprivate var fields: [MockFieldAdapter] {
        return [
            MockFieldAdapter(title: "Title", value: title),
            MockFieldAdapter(title: "Detail", value: detail),
            MockFieldAdapter(title: "Director", value: director),
            MockFieldAdapter(title: "Producer", value: producer),
            MockFieldAdapter(title: "Release Date", value: releaseDate),
            MockFieldAdapter(title: "RT Score", value: rtScore)
        ]
    }
}

extension FilmDetailAdapter: IDataService {
    
    func ed_getItems(id: String) -> Observable<[IEntityField]> {
        
        let parameters: [String: Any] = [
            ParameterKey.filmId: id
        ]
        
        return DataManager.shared
            .fetch(endpoint: EndpointMap.filmDetail, parameters: parameters)
            .map( { $0?.detail?.fields ?? [] })
    }
}

extension FilmDetailAdapter: IRouteService {
    
    func ed_navigate(to router: String, data: IEntityField?) {
        //DO NOTHING
    }
}

extension FilmDetailAdapter: IRepository {
    
    var ed_routerService: IRouteService? { return self }
    
    var ed_dataService: IDataService? { return self }
}
