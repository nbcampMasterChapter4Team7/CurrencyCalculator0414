//
//  ViewController.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/14/25.
//

import UIKit

class MainViewController: UIViewController {
    private var mainVM = MainViewModel(
        currencyUseCase: CurrencyUseCase(
            repository: CurrencyRepository(dataService: DataService())
        )
    )
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        mainVM.onCurrencyDataChanged = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func setUpTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CurrencyCell")
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainVM.getCurrencyData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath)
        let currency = mainVM.getCurrencyData()[indexPath.row]
        cell.textLabel?.text = "\(currency.currencyCode)(\(currency.country)): \(currency.rate)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currency = mainVM.getCurrencyData()[indexPath.row]
        print(currency)
    }
}
