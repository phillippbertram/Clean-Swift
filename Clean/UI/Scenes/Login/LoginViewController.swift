//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Material

final class LoginViewController: UIViewController, SegueHandlerType {

    enum SegueIdentifier: String {
        case showMain
    }

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: RaisedButton!

    var viewModel: LoginViewModel!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }

    private func setupBinding() {
        userNameTextField.rx.text.bind(to: viewModel.userName).addDisposableTo(disposeBag)
        passwordTextField.rx.text.bind(to: viewModel.password).addDisposableTo(disposeBag)

        loginButton.rx.action = viewModel.loginAction
        viewModel
                .loginAction
                .elements
                .subscribe(onNext: {
                    self.performSegue(withIdentifier: .showMain)
                })
                .addDisposableTo(disposeBag)
    }

}
