//
//  Untitled.swift
//  Take-Home
//
//  Created by Van Thanh on 20/5/25.
//

import Foundation
import RxSwift
import RxCocoa
import XCTest
@testable import Take_Home

class GithubUsersRepositoryTest: XCTestCase {
    
    // Target
    var repository: GithubUsersRepository!
    // mock
    var realmManagerMock: RealmManagerMock!
    var apiClientMock: APIClientMock!
    // variable
    var disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        realmManagerMock = RealmManagerMock()
        apiClientMock = APIClientMock()
        repository = GithubUsersRepository(realmDatabase: realmManagerMock,
                                           apiClient: apiClientMock)
    }
    
    /// ## testFetchUsersLocal
    /// ## [prerequisites]
    /// inputUserData
    ///## [Expected result]
    /// result?.count
    func testFetchUsersLocal() {
        
        let params: [Int] // inputUserData
        params = [3, 5, 6, 2, 0]
        runWithParams(params: params) { index, inputUserData in
            // Given
            let mockUserData = setupUsers(inputUserData)
            
            realmManagerMock.fetchUsersResult = mockUserData
            let ex = expectation(description: "\(#function)_\(index)")
            var result: [User]?
            // When
            repository
                .fetchUsersLocal()
                .subscribe(onNext: { users in
                    result = users
            }, onCompleted: {
                ex.fulfill()
            }).disposed(by: disposeBag)
            // Then
            wait(for: [ex], timeout: 2)
            XCTAssertEqual(result?.count, mockUserData.count)
        }
    }
    
    /// ## testSaveUsersStogate
    /// ## [prerequisites]
    /// inputUser
    ///## [Expected result]
    /// inputUser.count == realmManagerMock.saveUsersArg?.count
    func testSaveUsersStogate() {
        // Given
        let inputUser = setupUsers(3)
        // When
        repository.saveUsersStogate(users: inputUser)
        // Then
        XCTAssertEqual(inputUser.count, realmManagerMock.saveUsersArg?.count)
    }
    
    /// ## testGetUserFromServer
    /// ## [prerequisites]
    /// inputPage
    ///## [Expected result]
    /// apiClientMock.endPointArg
    func testGetUserFromServer() {
        // Given
        let ex = expectation(description: #function)
        let inputPage = 3
        // When
        repository
            .getUserFromServer(page: inputPage,
                               since: inputPage)
            .subscribe(onNext: { users in
                XCTAssertTrue(true)
            }, onCompleted: {
                ex.fulfill()
            })
            .disposed(by: disposeBag)
        wait(for: [ex], timeout: 2)
        // Then
        XCTAssertEqual(apiClientMock.endPointArg?.baseUrl, "https://api.github.com/")
        XCTAssertEqual(apiClientMock.endPointArg?.endPoint, "users")
        XCTAssertEqual(apiClientMock.endPointArg?.method, .get)
        let paramsPer_page = try? XCTUnwrap(apiClientMock.endPointArg?.params?["per_page"] as? Int)
        XCTAssertEqual(paramsPer_page, 20)
        let paramsSince = try? XCTUnwrap(apiClientMock.endPointArg?.params?["since"] as? Int)
        XCTAssertEqual(paramsSince, 60)
        
    }
    
    func setupUsers(_ total: Int) -> [User] {
        return (0..<total).map({User(id: $0)})
    }
    
}
