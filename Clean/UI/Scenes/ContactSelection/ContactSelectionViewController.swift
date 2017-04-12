//
// Created by Phillipp Bertram on 06/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import UIKit
import Domain
import RxSwift
import RxCocoa

public final class ContactSelectionViewController: UITableViewController {

    public var contactSelectionHandler: ((Contact) -> ())?
    public var viewModel: ContactSelectionViewModel!

    private let disposeBag = DisposeBag()

    public override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.contacts.asDriver().drive(onNext: { _ in
            self.tableView.reloadData()
        }).addDisposableTo(disposeBag)
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contacts.value.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = R.reuseIdentifier.contactSelectionCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) else {
            return UITableViewCell()
        }
        let contact = viewModel.contacts.value[indexPath.item]
        cell.textLabel?.text = contact.displayName
        return cell
    }

    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        let contact = viewModel.contacts.value[indexPath.item]
        contactSelectionHandler?(contact)
    }


}
