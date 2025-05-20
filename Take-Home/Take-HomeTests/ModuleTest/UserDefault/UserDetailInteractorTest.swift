//
//  UserDetailInteractorTest.swift
//  Take-Home
//
//  Created by Van Thanh on 21/5/25.
//

import XCTest
import RxSwift
@testable import Take_Home

final class UserDetailInteractorTest: XCTestCase {
    
    // Target
    var interactor: UserDetailInteractor!
    // Mock
    var mockRepo: UserDetailRepositoryMock!
    var disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        mockRepo = UserDetailRepositoryMock()
        interactor = UserDetailInteractor(userDetailRepository: mockRepo)
    }
    
    /// ## testGetUser_notError
    /// ## [prerequisites]
    /// userDetailsEntitySafe
    ///## [Expected result]
    /// userDetailsEntitySafe.id
    ///  userDetailsEntitySafe.login
    func testGetUser_notError() throws {
        // Given
        let data = jsonUserDetail.data(using: .utf8)!
        let userDetailsEntitySafe = try XCTUnwrap(try? JSONDecoder().decode(UserDetailsEntity.self, from: data))
        mockRepo.userDetailsEntity = userDetailsEntitySafe
        var result: UserDetailsEntity?
        let ex = expectation(description: #function)
        // When
        interactor.getUser(loginUserName: "vanthanh").subscribe { data in
            result = data
        } onCompleted: {
            ex.fulfill()
        }.disposed(by: disposeBag)
        wait(for: [ex], timeout: 2)
        // Then
        XCTAssertEqual(userDetailsEntitySafe.id, result?.id)
        XCTAssertEqual(userDetailsEntitySafe.login, result?.login)
    }
    
    /// ## testGetUser_error
    /// ## [prerequisites]
    /// mockRepo.userDetailsEntity = nil
    ///## [Expected result]
    /// result == nil
    func testGetUser_error() throws {
        // Given
        mockRepo.userDetailsEntity = nil
        var result: UserDetailsEntity?
        let ex = expectation(description: #function)
        // When
        interactor.getUser(loginUserName: "vanthanh")
            .subscribe { data in
            result = data
        } onCompleted: {
            ex.fulfill()
        }.disposed(by: disposeBag)
        wait(for: [ex], timeout: 2)
        // Then
        XCTAssertNil(result)
    }
    
}
