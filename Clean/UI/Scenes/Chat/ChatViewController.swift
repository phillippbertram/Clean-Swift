//
// Created by Phillipp Bertram on 02/04/2017.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Material
import RxSwift
import RxCocoa

public final class ChatViewController: TableViewController {

    var viewModel: ChatViewModel!

    private let disposeBag = DisposeBag()

    public override func viewDidLoad() {
        super.viewDidLoad()
    }

    public override func prepare() {
        super.prepare()
        viewModel.title.asDriver().drive(rx.title).addDisposableTo(disposeBag)
    }

}
