//
//  ViewController.swift
//  Clean
//
//  Created by Phillipp Bertram on 30/03/2017.
//  Copyright © 2017 LMIS AG. All rights reserved.
//

import UIKit
import Domain
import Data
import RxSwift
import RxCocoa
import Material

public class ChatListViewController: TableViewController {

    var viewModel: ChatListViewModel!

    private let disposeBag = DisposeBag()

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }

    // MARK: DataSource

    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.chats.value.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath)
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        cell.textLabel?.text = cellViewModel.text
        return cell
    }

    // MARK - Setup

    public override func prepare() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "chatCell")
        super.prepare()
    }

    private func setupBinding() {
        viewModel.title.asDriver().drive(rx.title).addDisposableTo(disposeBag)
        viewModel.chats.asDriver().drive(onNext: { _ in self.tableView.reloadData() }).addDisposableTo(disposeBag)
    }

}

