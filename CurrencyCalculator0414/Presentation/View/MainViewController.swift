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
    private var currencyListView: CurrencyListView!
    private var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        setupSearchBar()
        currencyListView.configureDelegate(self)
        mainVM.onCurrencyDataChanged = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.currencyListView.reloadData()
            }
        }
    }
    
    func setupTableView(){
        currencyListView = CurrencyListView(frame: view.bounds)
        view.addSubview(currencyListView)
        
        currencyListView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currencyListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            currencyListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            currencyListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currencyListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "통화 검색"
        searchBar.backgroundImage = UIImage()
        navigationItem.titleView = searchBar
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainVM.getCurrencyData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyListViewCell.identifier, for: indexPath) as! CurrencyListViewCell
        let currency = mainVM.getCurrencyData()[indexPath.row]
        cell.setupCurrencyInfo(currencyItem: currency)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currency = mainVM.getCurrencyData()[indexPath.row]
        let currencyVC = CurrencyViewController()
        currencyVC.currency = currency
        navigationController?.pushViewController(currencyVC, animated: true)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange: String) {
        mainVM.searchCurrency(textDidChange)
    }
}
