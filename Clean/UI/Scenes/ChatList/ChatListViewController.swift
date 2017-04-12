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

    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == R.segue.chatListViewController.contactSelection.identifier {
            guard let navVC = segue.destination as? UINavigationController,
                  let vc = navVC.topViewController as? ContactSelectionViewController else {
                return
            }
            vc.contactSelectionHandler = { [unowned self] contact, vc in
                log.debug("did select contact: \(contact)")
                vc.dismiss(animated: true)
                self.viewModel.startChat(forContact: contact)
            }
        }
    }

    // MARK: DataSource

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.chats.value.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = R.reuseIdentifier.chatCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) else {
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

        viewModel.showChat = { [unowned self] chatViewModel in
            let chatVC = R.storyboard.main.chatViewController()!
            chatVC.viewModel = chatViewModel
            self.navigationController?.pushViewController(chatVC, animated: true)
        }
    }

}

// MARK: - Actions

extension ChatListViewController {

    @IBAction func addAction(_ sender: Any) {

    }

}
