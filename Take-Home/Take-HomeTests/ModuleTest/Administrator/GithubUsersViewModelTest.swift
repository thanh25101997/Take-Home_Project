//
//  GithubUsersViewModel.swift
//  Take-Home
//
//  Created by Van Thanh on 19/5/25.
//

import Foundation
import RxSwift
import RxCocoa
import XCTest
@testable import Take_Home


class GithubUsersViewModelTest: XCTestCase {
    
    // Target
    var viewModel: GithubUsersViewModel!
    // mock
    var githubUsersNavigatorMock: GithubUsersNavigatorMock!
    var githubUsersInteractorMock: GithubUsersInteractorMock!
    
    var mockInput: GithubUsersViewModel.Input!
    var output: GithubUsersViewModel.Output!
    // Trigers
    var viewWillAppearTriger = PublishSubject<Bool>()
    var backBtnTriger = PublishSubject<Void>()
    var loadMoreUsersTriger = PublishSubject<Void>()
    var selectUserTriger = PublishSubject<User>()
    // variable
    var disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        githubUsersNavigatorMock =  GithubUsersNavigatorMock()
        githubUsersInteractorMock = GithubUsersInteractorMock()
        viewModel = GithubUsersViewModel(navigator: githubUsersNavigatorMock,
                                         interactor: githubUsersInteractorMock)
        mockInput = GithubUsersViewModel.Input(viewWillAppear: viewWillAppearTriger.asDriver(onErrorJustReturn: false),
                                               backBtn: backBtnTriger.asDriver(onErrorJustReturn: ()),
                                               loadMoreUsers: loadMoreUsersTriger,
                                               selectUser: PublishSubject<User>().asDriver(onErrorJustReturn: User(id: 1, login: "", avatarUrl: "", htmlUrl: "")))
        output = viewModel.transform(input: mockInput)
    }
    
    /// ## [prerequisites]
    /// mockIsFirstLaunchResult
    /// mockGetUsers
    /// mockListUser
    ///## [Expected result]
    /// outputGetUsersStogateCalled
    /// outputSaveFirstLaunchCalled
    /// outputSaveUsersStogate
    /// outputListUser
    func testViewWillAppearTriger() {
        let params: [(Bool, // mockIsFirstLaunchResult
                      [User], // mockGetUsers
                      [User], // mockListUser
                      Bool, // outputGetUsersStogateCalled
                      Bool, // outputSaveFirstLaunchCalled
                      [User]?, // outputSaveUsersStogate
                      [User])] // outputListUser
        params = [
            (true, [], [], true, false, nil, []),
            (true, setupUsers(4), [], true, false, nil, setupUsers(4)),
            (false, setupUsers(4), setupUsers(4), false, true, setupUsers(4), setupUsers(4))
        ]
        runWithParams(params: params) { index, param in
            // Given
            let (mockIsFirstLaunchResult,
                 mockGetUsers,
                 mockListUser,
                 outputGetUsersStogateCalled,
                 outputSaveFirstLaunchCalled,
                 outputSaveUsersStogate,
                 outputListUser) = param
            githubUsersInteractorMock.isFirstLaunchResult = mockIsFirstLaunchResult
            githubUsersInteractorMock.getUsersStogateResult = mockGetUsers
            githubUsersInteractorMock.getUsersResult = mockGetUsers
            output.listUser.accept(mockListUser)
            // When
            viewWillAppearTriger.onNext(true)
            // Then
            XCTAssertEqual(githubUsersInteractorMock.getUsersStogateCalled,
                           outputGetUsersStogateCalled,
                           "index \(index)")
            XCTAssertEqual(githubUsersInteractorMock.saveFirstLaunchCalled,
                           outputSaveFirstLaunchCalled,
                           "index \(index)")
            XCTAssertEqual(githubUsersInteractorMock.saveUsersStogateArg?.count,
                           outputSaveUsersStogate?.count,
                           "index \(index)")
            XCTAssertEqual(output.listUser.value.count,
                           outputListUser.count,
                           "index \(index)")
            
        }
    }
    
    /// ## testBackBtn
    /// ## [prerequisites]
    /// none
    ///## [Expected result]
    /// userDetailNavigatorMock.backToHomeCalled
    func testBackBtn() {
        // Given
        // When
        backBtnTriger.onNext(())
        // Then
        XCTAssertEqual(githubUsersNavigatorMock.backToHomeCalled, true)
    }
    
    func setupUsers(_ total: Int) -> [User] {
        return Array(repeating:  User(), count: total)
    }
    
}
