//
//  TableView.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/15/25.
//

import UIKit

class CurrencyListView: UIView {
    private let tableView = UITableView()

    init(){
        super.init(frame: .zero)
        setUpTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        tableView.register(CurrencyListViewCell.self, forCellReuseIdentifier: CurrencyListViewCell.identifier)
    }
    
    func configureDelegate(_ delegate: UITableViewDelegate & UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = delegate
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}
