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
    
    func el_navigate(to router: String, data: IEntity?)
}

public protocol IDataService {
    
    func el_getItems() -> Observable<[IEntity]>
}


public protocol IRepository: class {
    
    var el_routerService: IRouteService? { get }
    
    var el_dataService: IDataService? { get }
    
}
