//
//  CurrencyViewController.swift
//  CurrencyCalculator0414
//
//  Created by tlswo on 4/15/25.
//

import UIKit

class CurrencyViewController: UIViewController {
    private let currencyVM: CurrencyViewModel = CurrencyViewModel()
    var currency: CurrencyItem?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let currencyCodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "금액을 입력하세요"
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("환율 계산", for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemBlue
        return button
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "계산 결과가 여기에 표시됩니다."
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "환율 계산기"
        setupStackView()
        setupConstraint()
        button.addTarget(self, action: #selector(didTapCalculateButton), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let repository = LastViewedScreenRepository()
        let useCase = LastViewedScreenUseCase(repository: repository)

        useCase.save(screenName: "CurrencyCalculatePage", currency: currency)
    }
    
    func setupCurrencyCodeLabel() {
        currencyCodeLabel.text = currency?.currencyCode
    }
    
    func setupCountryLabel() {
        countryLabel.text = currency?.country
    }
    
    func setupStackView() {
        setupCurrencyCodeLabel()
        setupCountryLabel()
        stackView.addArrangedSubview(currencyCodeLabel)
        stackView.addArrangedSubview(countryLabel)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(textLabel)
        stackView.setCustomSpacing(5, after: currencyCodeLabel)
        view.addSubview(stackView)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            textField.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            button.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            textLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20)
        ])
    }
    
    @objc private func didTapCalculateButton() {
        guard let input = textField.text, !input.isEmpty,
              let rate = currency?.rate,
              let code = currency?.currencyCode else {
            return
        }
        guard let inputValue = Double(input) else {
            let alert = UIAlertController(title: "오류", message: "숫자를 입력해 주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            textField.text = ""
            return
        }
        textLabel.text = currencyVM.calculateCurrency(input: inputValue, rate: rate, currencyCode: code)
        textField.text = ""
    }
}
