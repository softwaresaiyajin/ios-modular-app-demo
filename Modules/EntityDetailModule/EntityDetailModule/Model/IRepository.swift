//
//  IRepository.swift
//  EntityListModule
//
//  Created by Gerald Adorza on 21/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation
import RxSwift

public protocol IRouteService {
    
    func ed_navigate(to router: String, data: IEntityField?)
}

public protocol IDataService {
    
    func ed_getItems(id: String) -> Observable<[IEntityField]>
}


public protocol IRepository: class {
    
    var ed_routerService: IRouteService? { get }
    
    var ed_dataService: IDataService? { get }
    
}
