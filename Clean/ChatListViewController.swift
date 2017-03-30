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

class ChatListViewController: UIViewController {

    let chatRepository: ChatRepositoryType = ChatRepository()
    lazy var getChatsUseCase: GetChatsUseCase = {
        return GetChatsUseCase(chatRepository: self.chatRepository)
    }()
    
    lazy var viewModel: ChatListViewModel = {
        return ChatListViewModel(getChatsUseCase: self.getChatsUseCase)
    }()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        viewModel.title.asDriver().drive(rx.title).addDisposableTo(disposeBag)
        viewModel.chats.asObservable().do(onNext: printChats).subscribe().addDisposableTo(disposeBag)
        
    }

    private func printChats(_ chats: [Chat]) {
        print("\(chats)")
    }

}

