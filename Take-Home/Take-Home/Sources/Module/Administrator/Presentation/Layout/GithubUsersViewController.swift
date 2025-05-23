//
//  GithubUsersViewController.swift
//  Take-Home
//
//  Created by Van Thanh on 14/5/25.
//

import UIKit
import RxSwift
import RxCocoa

class GithubUsersViewController: BaseViewController<GithubUsersViewModel> {

    @IBOutlet weak var usersTableView: UITableView!
    
    fileprivate var activityIndicator: LoadMoreActivityIndicator!
    private let loadMore: PublishSubject<Void> = .init()
    
    override func configView() {
        super.configView()
        setDefautNavigationBar(title: ScreenTitleConst.titleAdministrator)
        usersTableView.registerCell(for: "UsersTableViewCell")
        usersTableView.rx.setDelegate(self).disposed(by: disposeBag)
        activityIndicator = LoadMoreActivityIndicator(scrollView: usersTableView,
                                                      spacingFromLastCell: 10,
                                                      spacingFromLastCellWhenLoadMoreActionStart: 60)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let input = GithubUsersViewModel.Input(viewWillAppear: rx.viewWillAppear.asDriver(),
                                               backBtn: self.navigationItem.leftBarButtonItem?.rx.tap.asDriver(),
                                               loadMoreUsers: loadMore,
                                               selectUser: usersTableView.rx.safeModelSelected(User.self).asDriver())
        let output = viewModel.transform(input: input)
        
        output.listUser
            .observe(on: MainScheduler.instance)
            .bind(to: usersTableView.rx.items(cellIdentifier: "UsersTableViewCell",
                                              cellType: UsersTableViewCell.self)){
                (row, data, cell) in
                cell.setupView(user: data)
            }.disposed(by: disposeBag)
        
        output.isFetchProcess
            .observe(on: MainScheduler.instance)
            .filter({!$0})
            .subscribe { [weak self] value in
                self?.activityIndicator.stop()
            }.disposed(by: disposeBag)
    }
    
}

extension GithubUsersViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.activityIndicator.start {
            self.loadMore.onNext(())
        }
    }
}
