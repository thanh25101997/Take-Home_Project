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
        setDefautNavigationBar(title: "Github Users")
        usersTableView.registerCell(for: "UsersTableViewCell")
        usersTableView.tableFooterView = UIView()
        usersTableView.rx.setDelegate(self).disposed(by: disposeBag)
        activityIndicator = LoadMoreActivityIndicator(scrollView: usersTableView,
                                                      spacingFromLastCell: 10,
                                                      spacingFromLastCellWhenLoadMoreActionStart: 60)
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let input = GithubUsersViewModel.Input(viewWillAppear: rx.viewWillAppear,
                                               backBtn: self.navigationItem.leftBarButtonItem?.rx.tap.asDriver(),
                                               loadMoreUsers: loadMore)
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self?.activityIndicator.stop()
                }
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
