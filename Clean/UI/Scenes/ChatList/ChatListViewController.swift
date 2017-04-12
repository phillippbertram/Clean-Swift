//
//  ViewController.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 Phillipp Bertram. All rights reserved.
//

import UIKit
import Domain
import Data
import RxSwift
import RxCocoa
import Material

public class ChatListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    var viewModel: ChatListViewModel!

    private let disposeBag = DisposeBag()

    // MARK: Lifecycle

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }

    // MARK: DataSource

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.chats.value.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.chatCell, for: indexPath) else {
            return UITableViewCell()
        }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        cell.textLabel?.text = cellViewModel.text
        return cell
    }

    // MARK: Setup

    private func setupBinding() {
        viewModel.title.asDriver().drive(rx.title).addDisposableTo(disposeBag)

        viewModel.chats.asDriver()
            .drive(onNext: { [weak self] _ in self?.tableView.reloadData() })
            .addDisposableTo(disposeBag)
    }

}

// MARK: - Actions

extension ChatListViewController {

    @IBAction func addAction(_ sender: Any) {

    }

}
