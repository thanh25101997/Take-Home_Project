//
//  ViewModel.swift
//  Take-Home
//
//  Created by Van Thanh on 15/5/25.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class GithubUsersViewModel: ViewModelType {
    
    private var interactor: GithubUsersInteractorProtocol
    private var navigator: GithubUsersNavigatorProtocol
    private var disposeBag = DisposeBag()
    private var page = 0
    private var trackActivity: ActivityIndicator = .init()
    private var input: Input!
    private var output: Output!
    
    
    init(navigator: GithubUsersNavigatorProtocol,
         interactor: GithubUsersInteractorProtocol) {
        self.navigator = navigator
        self.interactor = interactor
    }
    
    struct Input {
        let viewWillAppear: Driver<Bool>
        let backBtn: Driver<Void>?
        let loadMoreUsers: PublishSubject<Void>
        let selectUser: Driver<User>
    }
    
    struct Output {
        let listUser: BehaviorRelay<[User]> = .init(value: [])
        let isFetchProcess: BehaviorRelay<Bool> = .init(value: false)
    }
    
    func transform(input: Input) -> Output {
        self.input = input
        self.output = Output()
        
        input.viewWillAppear
            .asObservable()
            .take(1)
            .flatMap { [weak self] _ -> Observable<[User]> in
            guard let self else { return .empty() }
            if self.interactor.isFirstLaunch() {
                return self.interactor.getUsersStogate()
            } else {
                return self.interactor.getUsers(page: self.page,
                                                since: 20,
                                                currentUsers: self.output.listUser.value)
                .do(onNext: { users in
                    self.interactor.saveFirstLaunch()
                    self.interactor.saveUsersStogate(users: users)
                })
                .trackActivity(self.trackActivity)
            }
        }
            .subscribe(onNext: { [weak self] users in
                guard let self else { return }
                print(users.count)
                self.output.listUser.accept(users)
                self.page += 1
            }, onError: { eror in
                print(eror)
            }, onCompleted: nil,
                       onDisposed: nil)
        .disposed(by: disposeBag)
        
        // Request getUser
        input.loadMoreUsers
            .flatMap { [weak self] _ -> Observable<[User]> in
                guard let self else { return .empty() }
                return self.interactor.getUsers(page: self.page,
                                                since: 20,
                                                currentUsers: self.output.listUser.value)
                .trackActivity(self.trackActivity)
            }.subscribe(onNext: { [weak self] users in
                guard let self else { return }
                print(users.count)
                self.output.listUser.accept(users)
                self.page += 1
            }, onError: { error in
                print(error)
            }, onDisposed: {
                print("onDisposed")
            })
            .disposed(by: disposeBag)
        
        input.backBtn?
            .drive(onNext: { [weak self] _ in
                self?.navigator.backToHome()
            }).disposed(by: disposeBag)
        
        input.selectUser
            .drive(onNext: { [weak self] user in
                self?.navigator.gotoUserDetail(loginUsername: user.login ?? "")
            }).disposed(by: disposeBag)
        
        trackActivity
            .asSharedSequence()
            .asObservable()
            .bind(to: self.output.isFetchProcess)
            .disposed(by: disposeBag)
        
        return output
    }
    
}


