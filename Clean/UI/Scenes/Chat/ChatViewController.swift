//
// Created by Phillipp Bertram on 02/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import UIKit
import Material
import RxSwift
import RxCocoa

public final class ChatViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: FlatButton!
    @IBOutlet weak var tableView: TableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }

    var viewModel: ChatViewModel!

    private let disposeBag = DisposeBag()

    public override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
    }

    private func prepare() {
        viewModel.title.asDriver().drive(rx.title).addDisposableTo(disposeBag)

        sendButton.rx.tap.subscribe { [unowned self] _ in
            self.viewModel.sendTextMessage(self.messageTextField.text ?? "")
        }.addDisposableTo(disposeBag)

        viewModel.messages.asDriver().drive(onNext: { [unowned self] _ in
            self.tableView.reloadData()
        }).addDisposableTo(disposeBag)

    }

}

// MARK: - UITableViewDataSource

extension ChatViewController: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.messages.value.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.messageCell, for: indexPath)!

        let message = viewModel.messages.value[indexPath.item]

        cell.textLabel?.text = message.sender.displayName
        cell.detailTextLabel?.text = message.text

        return cell
    }

}

// MARK: - UITableViewDelegate

extension ChatViewController: UITableViewDelegate {

}
