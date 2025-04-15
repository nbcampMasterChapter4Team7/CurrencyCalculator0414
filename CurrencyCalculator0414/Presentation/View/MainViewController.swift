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
        ),
        favoriteUseCase: FavoriteCurrencyUseCase(
            repository: FavoriteCurrencyRepository()
        ),
        cachedCurrencyRateUseCase: CachedCurrencyRateUseCase(
            repository: CachedCurrencyRateRepository()
        )
    )
    private var currencyListView: CurrencyListView = CurrencyListView()
    private var searchBar: UISearchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "환율 정보"
        setupSearchBar()
        setupTableView()
        currencyListView.configureDelegate(self)
        mainVM.onCurrencyDataChanged = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.currencyListView.reloadData()
            }
        }
    }
    
    func setupTableView(){
        view.addSubview(currencyListView)
        currencyListView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currencyListView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            currencyListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currencyListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            currencyListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "통화 검색"
        searchBar.backgroundImage = UIImage()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
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
        cell.onTapFavorite = { [weak self] in
            self?.mainVM.toggleFavorite(for: currency.currencyCode)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
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
