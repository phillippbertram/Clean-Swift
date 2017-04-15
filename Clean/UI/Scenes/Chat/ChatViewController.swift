//
// Created by Phillipp Bertram on 02/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Material
import RxSwift
import RxCocoa

public final class ChatViewController: TableViewController {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: FlatButton!

    var viewModel: ChatViewModel!

    private let disposeBag = DisposeBag()

    public override func prepare() {
        super.prepare()

        viewModel.title.asDriver().drive(rx.title).addDisposableTo(disposeBag)

        sendButton.rx.tap.subscribe { [unowned self] _ in
            self.viewModel.sendTextMessage(self.messageTextField.text ?? "")
        }.addDisposableTo(disposeBag)
    }

}
