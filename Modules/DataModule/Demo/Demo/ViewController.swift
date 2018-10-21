//
//  ViewController.swift
//  Demo
//
//  Created by Gerald Adorza on 21/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import UIKit
import DataModule
import RxSwift

protocol IEndpoint {
    var id: String? { get }
    func send(parameters: [String: Any]?, disposeBag: DisposeBag)
}

extension Endpoint: IEndpoint {
    
    var id: String? { return url }
    
    func send(parameters: [String: Any]?, disposeBag: DisposeBag) {
        
        DataManager.shared
            .fetch(endpoint: self, parameters: parameters)
            .subscribe(onNext: { (mapper) in
                guard let value = mapper else { return }
                debugPrint("response: \(value)")
            })
            .disposed(by: disposeBag)
    }
}

struct EndpointWrapper {
    var endpoint: IEndpoint
    var parameters: [String: Any]?
}

class ViewController: UITableViewController {

    struct Constant {
        static let reuseId = "UITableViewCell"
    }
    
    
    private var disposeBag = DisposeBag()

    private let endpoints: [EndpointWrapper] = [
        
        EndpointWrapper(endpoint: EndpointMap.filmList, parameters: nil),
        EndpointWrapper(endpoint: EndpointMap.filmDetail,
                        parameters: [ParameterKey.filmId: "45db04e4-304a-4933-9823-33f389e8d74d"]),
        
        EndpointWrapper(endpoint: EndpointMap.personList, parameters: nil),
        EndpointWrapper(endpoint: EndpointMap.personDetail,
                        parameters: [ParameterKey.personId: "ba924631-068e-4436-b6de-f3283fa848f0"]),
        
        EndpointWrapper(endpoint: EndpointMap.locationList, parameters: nil),
        EndpointWrapper(endpoint: EndpointMap.locationDetail,
                        parameters: [ParameterKey.locationId: "11014596-71b0-4b3e-b8c0-1c4b15f28b9a"]),
        
        EndpointWrapper(endpoint: EndpointMap.speciesList, parameters: nil),
        EndpointWrapper(endpoint: EndpointMap.specieDetail,
                        parameters: [ParameterKey.specieId: "b5a92d0e-5fb4-43d4-ba60-c012135958e4"]),
        
        EndpointWrapper(endpoint: EndpointMap.vehicleList, parameters: nil),
        EndpointWrapper(endpoint: EndpointMap.vehicleDetail,
                        parameters: [ParameterKey.vehicleId: "4e09b023-f650-4747-9ab9-eacf14540cfb"])
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constant.reuseId)
        
        let dataProvider = DataManager.shared
        dataProvider.startSession(rootUrl: "https://ghibliapi.herokuapp.com")
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
     
        let data = endpoints[indexPath.row]
        
        data.endpoint
            .send(parameters: data.parameters,
                  disposeBag: disposeBag)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.reuseId)
        let data = endpoints[indexPath.row]
        cell?.textLabel?.text = data.endpoint.id
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return endpoints.count
    }

}
