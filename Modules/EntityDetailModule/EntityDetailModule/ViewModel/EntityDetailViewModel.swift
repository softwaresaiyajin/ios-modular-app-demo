//
//  EntityListViewModel.swift
//  EntityListModule
//
//  Created by Gerald Adorza on 21/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation
import RxSwift

struct EntityDetailViewModel {
    
    unowned let repository: IRepository
    
    func getEntityList(id: String) -> Observable<[IEntityField]> {
        return repository
            .ed_dataService?
            .ed_getItems(id: id) ?? Observable.just([])
    }
    
    func navigate(to route: String, data: IEntityField?) {
        repository
            .ed_routerService?
            .ed_navigate(to: route, data: data)
    }
}
