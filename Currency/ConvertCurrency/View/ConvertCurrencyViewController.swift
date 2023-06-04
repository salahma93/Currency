//
//  ConvertCurrencyViewController.swift
//  Currency
//
//  Created by Mohamed Salah on 02/06/2023.
//

import UIKit
import RxSwift
import RxCocoa

final class ConvertCurrencyViewController: UIViewController {
	//MARK: - IBOutlets
	@IBOutlet private weak var amountTextField: UITextField!
	@IBOutlet private weak var fromTextField: UITextField!
	@IBOutlet private weak var toTextField: UITextField!
	
	@IBOutlet private weak var errorTextLabel: UILabel!
	@IBOutlet private weak var convertedAmountLabel: UILabel!
	@IBOutlet private weak var toButton: UIButton!
	@IBOutlet private weak var fromButton: UIButton!
	
	//MARK: - UIViews
	private let fromPickerView =  UIPickerView()
	private let toPickerView =  UIPickerView()
	
	//MARK: - Variables
	private let viewModel: ConvertCurrencyViewModelProtocol
	private let disposeBag = DisposeBag()
	
	//MARK:  - init(s)
	init(viewModel: ConvertCurrencyViewModelProtocol) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("Cannot init without view model object")
	}
	
	//MARK: - Life Cycle Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		
		fromTextField.inputView = fromPickerView
		toTextField.inputView = toPickerView
		
		setupConvertToCurrencyBindings()
		setupConvertFromCurrencyBindings()
		setupConversionBindings()
		setupErrorBindings()
		
		viewModel.start()
	}
	
	//MARK: - Setup Symbols Selection
	private func setupConvertToCurrencyBindings() {
		toButton.rx
			.tap
			.subscribe { [weak self] element in
				self?.toTextField.becomeFirstResponder()
			}.disposed(by: disposeBag)
		
		viewModel.symbols
			.subscribe(on: MainScheduler.instance)
			.bind(to: toPickerView.rx.itemTitles) { _, item in
				return "\(item)"
			}.disposed(by: disposeBag)
		
		toPickerView.rx
			.modelSelected(String.self)
			.subscribe { [weak self] model in
				self?.toTextField.text = model.first
				self?.toTextField.resignFirstResponder()
			}.disposed(by: disposeBag)
	}
	
	private func setupConvertFromCurrencyBindings() {
		fromButton.rx
			.tap
			.subscribe { element in
				self.fromTextField.becomeFirstResponder()
			}.disposed(by: disposeBag)
		
		viewModel.symbols
			.subscribe(on: MainScheduler.instance)
			.bind(to: fromPickerView.rx.itemTitles) { _, item in
				return "\(item)"
			}.disposed(by: disposeBag)
		
		fromPickerView.rx
			.modelSelected(String.self)
			.subscribe { [weak self] model in
				self?.fromTextField.text = model.first
				self?.fromTextField.resignFirstResponder()
			}.disposed(by: disposeBag)
	}
	
	private func setupConversionBindings() {
		let observable = Observable
			.combineLatest(fromPickerView.rx.modelSelected(String.self),
						   toPickerView.rx.modelSelected(String.self)) {
				return (from: $0.first, to: $1.first)
			}
		
		Observable
			.combineLatest(observable, amountTextField.rx.text) {
				return (from: $0.from, to: $0.to, amountText: $1)
			}
			.filter{ $0.amountText?.isEmpty == false }
			.debounce(RxTimeInterval.milliseconds(300), scheduler: MainScheduler.instance)
			.subscribe(onNext: { [weak self] input in
				self?.viewModel.convert(from: input.from, to: input.to, amount: input.amountText)
			}).disposed(by: disposeBag)
		
		viewModel.convertedAmount
			.subscribe(on: MainScheduler.instance)
			.bind(to: convertedAmountLabel.rx.text)
			.disposed(by: disposeBag)
	}
	
	private func setupErrorBindings() {
		viewModel.errorsSubject
			.map { $0?.localizedDescription }
			.bind(to: errorTextLabel.rx.text)
			.disposed(by: disposeBag)
	}
}
