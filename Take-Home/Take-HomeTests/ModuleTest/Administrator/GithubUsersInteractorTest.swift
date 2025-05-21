//
//  GithubUsersInteractorTest.swift
//  Take-Home
//
//  Created by Van Thanh on 18/5/25.
//
import XCTest
import RxSwift
@testable import Take_Home

final class GithubUsersInteractorTest: XCTestCase {
    
    // Target
    var interactor: GithubUsersInteractor!
    // mock
    var githubUsersRepositoryMock: GithubUsersRepositoryMock!
    // variable
    var disposeBag = DisposeBag()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        githubUsersRepositoryMock = GithubUsersRepositoryMock()
        interactor = GithubUsersInteractor(githubUsersRepository: githubUsersRepositoryMock)
        
    }
    
    /// ## testIsFirstLaunch
    /// ## [prerequisites]
    /// mockFirstLaunch
    ///## [Expected result]
    /// outputIsFirstLaunch
    func testIsFirstLaunch() throws {
        let params: [(Bool, // mockFirstLaunch
                      Bool)] // outputIsFirstLaunch
        params = [(true, false),
                  (false, true)]
        params.enumerated().forEach { index, params in
            XCTContext.runActivity(named: "\(#function)_\(index)") { activity in
                // given
                let (mockFirstLaunch,
                     outputIsFirstLaunch) = params
                UserDefaultService.shared.setFirstLaunch(value: mockFirstLaunch)
                // when
                let result = interactor.isFirstLaunch()
                // then
                XCTAssertEqual(result,
                               outputIsFirstLaunch,
                               "index: \(index)")
            }
        }
    }
    
    /// ## testSaveFirstLaunch
    /// ## [prerequisites]
    /// hasLaunchedBeforeMock
    ///## [Expected result]
    /// hasLaunchedBefore
    func testSaveFirstLaunch() {
        // given
        UserDefaults.standard.set(false, forKey: UserDefaultConst.hasOpenedAppOnce)
        // when
        interactor.saveFirstLaunch()
        // then
        XCTAssertEqual(UserDefaults.standard.bool(forKey: UserDefaultConst.hasOpenedAppOnce),
                       true)
    }
    
    /// ## testGetUsers
    /// ## [prerequisites]
    /// inputPage
    /// inputSince
    /// inputCurrentUsers
    ///## [Expected result]
    /// githubUsersRepositoryMock.getUserFromServerArg
    /// resultGetUsers.count
    func testGetUsers() {
        // given
        let inputPage = 20
        let inputSince = 20
        let inputCurrentUsers = [User(id: 1, login: "", avatarUrl: "", htmlUrl: ""),
                                 User(id: 2, login: "", avatarUrl: "", htmlUrl: "")]
        githubUsersRepositoryMock.getUserFromServerOutput = [User(id: 3, login: "", avatarUrl: "", htmlUrl: "")]
        let output = 3
        let expectation = expectation(description: #function)
        var resultGetUsers: [User] = []
        // when
        interactor.getUsers(page: inputPage,
                            since: inputSince,
                            currentUsers: inputCurrentUsers)
        .subscribe(
            onNext: { users in
                resultGetUsers = users
            },onDisposed: {
                expectation.fulfill()
            })
        .disposed(by: disposeBag)
        wait(for: [expectation],
             timeout: 2)
        // then
        XCTAssertEqual(githubUsersRepositoryMock.getUserFromServerArg?.0, inputPage)
        XCTAssertEqual(githubUsersRepositoryMock.getUserFromServerArg?.1, inputSince)
        XCTAssertEqual(resultGetUsers.count, output)
    }
    
    /// ## testGetUsersStogate
    /// ## [prerequisites]
    /// none
    ///## [Expected result]
    /// githubUsersRepositoryMock.fetchUsersLocalCalled
    func testGetUsersStogate() {
        // given
        // when
        interactor
            .getUsersStogate()
            .subscribe()
            .disposed(by: disposeBag)
        // mock
        XCTAssertEqual(githubUsersRepositoryMock.fetchUsersLocalCalled,
                       true)
    }
    
    /// ## testSaveUsersStogate
    /// ## [prerequisites]
    /// inputUsers
    ///## [Expected result]
    /// githubUsersRepositoryMock.saveUsersStogateArg
    func testSaveUsersStogate() {
        // given
        let inputUsers = [User(id: 1, login: "", avatarUrl: "", htmlUrl: ""),
                          User(id: 2, login: "", avatarUrl: "", htmlUrl: "")]
        // when
        interactor
            .saveUsersStogate(users: inputUsers)
        // then
        XCTAssertEqual(githubUsersRepositoryMock.saveUsersStogateArg?.count,
                       inputUsers.count)
    }
    
}
