//
//  ViewController.swift
//  Checkbox
//
//  Created by ThanDucHuy on 23/06/2021.
//
import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var confirmationCheckBox: CustomCheckbox!
    @IBOutlet weak var showAgainCheckBox: CustomCheckbox!
    @IBOutlet weak var submitButton: UIButton!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmationCheckBox
            .isCheck
            .do { [weak self] in
                self?.submitButton.isEnabled = $0
                self?.submitButton.backgroundColor = $0 ? UIColor(named: "check") : UIColor(named: "uncheck")
            }
            .subscribe(onDisposed:  {})
            .disposed(by: bag)
    }
    
    
    @IBAction func tapSubmitButton(_ sender: Any) {
        guard let isDontShowAgain = try? showAgainCheckBox.isCheck.value() else { return }
        print(isDontShowAgain)
    }
}

