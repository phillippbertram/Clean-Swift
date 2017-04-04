//
// Created by Phillipp Bertram on 03/04/2017.
// Copyright (c) 2017 LMIS AG. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Material

final class LoginViewController: UIViewController {

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
        userNameTextField.rx.text.bindTo(viewModel.userName).addDisposableTo(disposeBag)
        passwordTextField.rx.text.bindTo(viewModel.password).addDisposableTo(disposeBag)

        loginButton.rx.action = viewModel.loginAction
        viewModel
                .loginAction
                .elements
                .subscribe(onNext: {
                    let vc = R.storyboard.main.chatListViewController()!
                    self.navigationController?.pushViewController(vc, animated: true)
                })
                .addDisposableTo(disposeBag)

        viewModel
                .loginAction
                .errors
                .subscribe(onNext: { actionError in
                    print("Login Failed with error \(actionError)")
                })
                .addDisposableTo(disposeBag)
    }

}
