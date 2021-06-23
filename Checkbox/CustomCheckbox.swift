//
//  CustomCheckbox.swift
//  Checkbox
//
//  Created by ThanDucHuy on 23/06/2021.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class CustomCheckbox: UIView {
    private var checkBoxView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.cornerRadius = 8
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public var titleLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.textColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public var checkLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = .black
        $0.text = "✓"
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @IBInspectable var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    let isCheck = BehaviorSubject<Bool>(value: false)
    let bag = DisposeBag()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .clear
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTapCheckBox))
        checkBoxView.addGestureRecognizer(tap)
        checkBoxView.isUserInteractionEnabled = true
        checkLabel.isHidden = true
        
        addSubview(checkBoxView)
        addSubview(titleLabel)
        addSubview(checkLabel)
        
        isCheck.subscribe { [weak self] in
            self?.checkLabel.isHidden = !$0
        }
        .disposed(by: bag)
    }
    
    @objc private func handleTapCheckBox() {
        guard let newIsCheck = try? !isCheck.value() else { return }
        isCheck.onNext(newIsCheck)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        checkBoxView.snp.makeConstraints {
            $0.width.height.equalTo(30)
            $0.left.equalTo(14)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(checkBoxView.snp.right).offset(14)
            $0.right.equalToSuperview().offset(14)
            $0.centerY.equalToSuperview()
        }
        
        checkLabel.snp.makeConstraints {
            $0.centerX.equalTo(checkBoxView.snp.centerX)
            $0.centerY.equalTo(checkBoxView.snp.centerY)
        }
    }
}
