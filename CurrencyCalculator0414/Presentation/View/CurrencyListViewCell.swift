//
//  CustomCell.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/15/25.
//

import UIKit

class CurrencyListViewCell: UITableViewCell {
    static let identifier = "CurrencyCell"
    
    var onTapFavorite: (() -> Void)?
    
    var currencyCodeLabel = UILabel()
    var countryLabel = UILabel()
    var rateLabel = UILabel()
    var arrowImageView = UIImageView()
    var favoriteImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(currencyCodeLabel)
        contentView.addSubview(countryLabel)
        contentView.addSubview(rateLabel)
        contentView.addSubview(arrowImageView)
        contentView.addSubview(favoriteImageView)
        setupConstraints()
        setupFavoriteTapGesture()
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
        
        if currencyItem.isDown == .down {
            arrowImageView.image = .init(systemName: "arrowtriangle.down")
        } else if currencyItem.isDown == .up {
            arrowImageView.image = .init(systemName: "arrowtriangle.up")
        } else {
            arrowImageView.image = .init(systemName: "arrowtriangle.up")
            arrowImageView.tintColor = .clear
        }
        
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
            currencyCodeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            currencyCodeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            currencyCodeLabel.bottomAnchor.constraint(equalTo: countryLabel.topAnchor, constant: -5),
            countryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            countryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            rateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rateLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -5),
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: favoriteImageView.leadingAnchor,constant: -10),
            favoriteImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            favoriteImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    private func setupFavoriteTapGesture() {
        favoriteImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(favoriteTapped))
        favoriteImageView.addGestureRecognizer(tap)
    }

    @objc private func favoriteTapped() {
        onTapFavorite?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
