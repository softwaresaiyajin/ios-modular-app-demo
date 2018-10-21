//
//  AppProvider.swift
//  ModularApp
//
//  Created by Gerald Adorza on 21/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import Foundation
import EntityListModule

class FilmListAdapter { }
class PersonListAdapter { }
class VehicleListAdapter { }
class LocationListAdapter { }
class SpecieListAdapter { }

class FilmDetailAdapter { }
class PersonDetailAdapter { }
class VehicleDetailAdapter { }
class LocationDetailAdapter { }
class SpecieDetailAdapter { }

class AppProvider {
    
    var filmListProvider = FilmListAdapter()
    var personListProvider = PersonListAdapter()
    var vehicleListProvider = VehicleListAdapter()
    var locationListProvider = LocationListAdapter()
    var specieListProvider = SpecieListAdapter()

    var filmDetailProvider = FilmDetailAdapter()
    var personDetailProvider = PersonDetailAdapter()
    var vehicleDetailProvider = VehicleDetailAdapter()
    var locationDetailProvider = LocationDetailAdapter()
    var specieDetailProvider = SpecieDetailAdapter()
}
