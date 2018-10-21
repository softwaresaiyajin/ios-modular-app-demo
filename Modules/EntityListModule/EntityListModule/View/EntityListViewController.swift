//
//  EntityListViewController.swift
//  EntityListModule
//
//  Created by Gerald Adorza on 21/10/2018.
//  Copyright © 2018 Gerald Adorza. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public class EntityListViewController: UITableViewController {

    fileprivate struct Constants {
        static let reuseId = "__reuse_id__"
    }
    
    private lazy var bag: DisposeBag = { return DisposeBag() }()
    
    private var viewModel: EntityListViewModel?
    
    private let datasource = Variable<[IEntity]>([])
    
    public var repository: IRepository? {
        get { return viewModel?.repository }
        set {
            guard let value = newValue, viewModel == nil else { return }
            viewModel = EntityListViewModel(repository: value)
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupDataBinding()
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func setupUI() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.reuseId)
    }
    
    fileprivate func setupDataBinding() {

        datasource
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: Constants.reuseId,
                                         cellType: UITableViewCell.self)) {
                                            (row: Int, element: IEntity, cell: UITableViewCell) in
                                            cell.textLabel?.text = element.el_name
                                            cell.accessoryType = .disclosureIndicator
            }
            .disposed(by: bag)

        tableView.rx
            .itemSelected
            .subscribe(onNext: { [weak self] current in
                let data = self?.datasource.value[current.row]
                self?.viewModel?.navigate(to: Route.detail, data: data)
            })
            .disposed(by: bag)
        
        viewModel?
            .getEntityList()
            .subscribe(onNext : { [weak self] current in
                self?.datasource.value = current
            })
            .disposed(by: bag)
    }
}
