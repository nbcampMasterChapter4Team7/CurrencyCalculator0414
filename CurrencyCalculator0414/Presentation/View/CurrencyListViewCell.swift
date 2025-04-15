//
//  CustomCell.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/15/25.
//

import UIKit

class CurrencyListViewCell: UITableViewCell {
    static let identifier = "CurrencyCell"
    
    var currencyCodeLabel = UILabel()
    var countryLabel = UILabel()
    var rateLabel = UILabel()
    var arrowImageView = UIImageView()
    var favoriteImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(currencyCodeLabel)
        addSubview(countryLabel)
        addSubview(rateLabel)
        addSubview(arrowImageView)
        addSubview(favoriteImageView)
        setupConstraints()
    }
    
    func toFourDecimalString(_ rate: Double) -> String {
        return String(format: "%.4f", rate)
    }
    
    func setupCurrencyInfo(currencyItem: CurrencyItem) {
        currencyCodeLabel.text = currencyItem.currencyCode
        currencyCodeLabel.font = .systemFont(ofSize: 18, weight: .bold)
        currencyCodeLabel.textColor = .black
        
        countryLabel.text = currencyItem.country
        countryLabel.font = .systemFont(ofSize: 14, weight: .light)
        countryLabel.textColor = .gray
        
        rateLabel.text = toFourDecimalString(currencyItem.rate)
        rateLabel.font = .systemFont(ofSize: 16, weight: .medium)
        rateLabel.textColor = .black
        
        arrowImageView.image = .init(systemName: currencyItem.isDown ? "arrowtriangle.down" : "arrowtriangle.up")
        
        favoriteImageView.image = .init(systemName: currencyItem.isFavorite ? "star.fill" : "star")
        favoriteImageView.tintColor = .systemYellow
    }
    
    func setupConstraints() {
        currencyCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        rateLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        favoriteImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currencyCodeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            currencyCodeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            currencyCodeLabel.bottomAnchor.constraint(equalTo: countryLabel.topAnchor, constant: -5),
            countryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            countryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            rateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            rateLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -5),
            arrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: favoriteImageView.leadingAnchor,constant: -10),
            favoriteImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            favoriteImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
