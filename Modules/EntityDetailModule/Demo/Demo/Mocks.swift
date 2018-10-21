//
//  Mocks.swift
//  Demo
//
//  Created by Gerald Adorza on 21/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation
import EntityDetailModule
import RxSwift

struct MockEntity {
    var id: String
    var name: String
    var gender: String
    var age: String
    var eyeColor: String
    var hairColor: String
}

extension MockEntity {
    
    var fields: [MockEntityField] {
        return [
            MockEntityField(title: "Id", detail: id),
            MockEntityField(title: "Name", detail: name),
            MockEntityField(title: "Gender", detail: gender),
            MockEntityField(title: "Age", detail: age),
            MockEntityField(title: "Eye Color", detail: eyeColor),
            MockEntityField(title: "Hair Color", detail: hairColor)
        ]
    }
}

struct MockEntityField {
    var title: String
    var detail: String
}

extension MockEntityField: IEntityField {
    
    var ed_id: String? { return nil }
    
    var ed_title: String? { return title }
    
    var ed_detail: String? { return detail }
}


public class AppProvider { }

extension AppProvider: IRouteService {
    
    public func ed_navigate(to router: String, data: IEntityField?) {
        
    }
}

extension AppProvider: IDataService {
    
    public func ed_getItems(id: String) -> Observable<[IEntityField]> {
        let entity = MockEntity(id: id,
                                name: "Ashitaka",
                                gender: "male",
                                age: "late teens",
                                eyeColor: "brown",
                                hairColor: "brown")
        
        return Observable.just(entity.fields)
    }

}

extension AppProvider: IRepository {
    
    public var ed_routerService: IRouteService? { return self }
    
    public var ed_dataService: IDataService? { return self }
    
}

