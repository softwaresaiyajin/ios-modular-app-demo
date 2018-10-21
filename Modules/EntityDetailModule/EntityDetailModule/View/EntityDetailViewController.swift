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

public class EntityDetailViewController: UITableViewController {

    fileprivate struct Constants {
        static let reuseId = "__reuse_id__"
    }
    
    private lazy var bag: DisposeBag = { return DisposeBag() }()
    
    private var viewModel: EntityDetailViewModel?
    
    private let datasource = Variable<[IEntityField]>([])
    
    public var input: Input?
    
    public var repository: IRepository? {
        get { return viewModel?.repository }
        set {
            guard let value = newValue, viewModel == nil else { return }
            viewModel = EntityDetailViewModel(repository: value)
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
        tableView.register(EntityDetailTableViewCell.self, forCellReuseIdentifier: Constants.reuseId)
    }
    
    
    
    fileprivate func setupDataBinding() {

        var thisId: String? = nil
        
        if let value = input {
            switch(value) {
            case .basic(let id, let name):
                thisId = id
                title = name
            }
        }
        
        datasource
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: Constants.reuseId,
                                         cellType: EntityDetailTableViewCell.self)) {
                                            (row: Int, element: IEntityField, cell: EntityDetailTableViewCell) in
                                      
                                            cell.textLabel?.text = element.ed_title
                                            cell.detailTextLabel?.text = element.ed_detail
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
            .getEntityList(id: thisId ?? "")
            .subscribe(onNext : { [weak self] current in
                self?.datasource.value = current
            })
            .disposed(by: bag)
    }
}
