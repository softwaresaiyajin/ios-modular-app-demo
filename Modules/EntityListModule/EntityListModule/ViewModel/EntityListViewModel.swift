//
//  EntityListViewModel.swift
//  EntityListModule
//
//  Created by Gerald Adorza on 21/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation
import RxSwift

struct EntityListViewModel {
    
    unowned let repository: IRepository
    
    func getEntityList() -> Observable<[IEntity]> {
        return repository.el_dataService?.el_getItems() ?? Observable.just([])
    }
    
    func navigate(to route: String, data: IEntity?) {
        repository
            .el_routerService?
            .el_navigate(to: route, data: data)
    }
}
