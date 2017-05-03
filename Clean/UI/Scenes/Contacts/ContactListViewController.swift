//
// Created by Phillipp Bertram on 06/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Material
import RxSwift
import RxCocoa
import Action

public final class ContactListViewController: UITableViewController {

    @IBOutlet weak var refreshButton: UIBarButtonItem!

    var viewModel: ContactListViewModel!

    private let disposeBag = DisposeBag()

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }

    private func setupBinding() {
        viewModel.contacts.asDriver().drive { [unowned self] _ in
            self.tableView.reloadData()
        }.addDisposableTo(disposeBag)

        refreshButton.rx.action = viewModel.refreshAction
    }

    // MARK: UITableViewDataSource

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contacts.value.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = R.reuseIdentifier.contactCell
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)!

        let contact = viewModel.contacts.value[indexPath.item]
        cell.textLabel?.text = contact.displayName

        return cell
    }

}
