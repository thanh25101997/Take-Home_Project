//
//  UserDetailViewModelTest.swift
//  Take-Home
//
//  Created by Van Thanh on 21/5/25.
//

import Foundation
import RxSwift
import RxCocoa
import XCTest
@testable import Take_Home


class UserDetailViewModelTest: XCTestCase {
    
    // Target
    var viewModel: UserDetailViewModel!
    // mock
    var userDetailNavigatorMock: UserDetailNavigatorMock!
    var userDetailInteractorMock: UserDetailInteractorMock!
    
    var mockInput: UserDetailViewModel.Input!
    var output: UserDetailViewModel.Output!
    // Trigers
    var viewWillAppearTriger = PublishSubject<Bool>()
    var backBtnTriger = PublishSubject<Void>()
    // variable
    var disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        userDetailNavigatorMock =  UserDetailNavigatorMock()
        userDetailInteractorMock = UserDetailInteractorMock()
        viewModel = UserDetailViewModel(navigator: userDetailNavigatorMock,
                                        interactor: userDetailInteractorMock,
                                        loginUsername: "jvantuyl")
        mockInput = UserDetailViewModel.Input(viewWillAppear: viewWillAppearTriger.asDriver(onErrorJustReturn: true),
                                              backBtn: backBtnTriger.asDriver(onErrorJustReturn: ()))
        output = viewModel.transform(input: mockInput)
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
        XCTAssertEqual(userDetailNavigatorMock.backToHomeCalled, true)
    }
    
    
    /// ## testViewWillAppear
    /// ## [prerequisites]
    /// userDetailsEntitySafe
    /// ## [Expected result]
    /// userDetailInteractorMock.getUserArg
    /// output.userDetails.value?.id
    /// output.userDetails.value?.login
    func testViewWillAppear() throws {
        // Given
        let data = jsonUserDetail.data(using: .utf8)!
        let userDetailsEntitySafe = try XCTUnwrap(try? JSONDecoder().decode(UserDetailsEntity.self, from: data))
        userDetailInteractorMock.getUserResult = userDetailsEntitySafe
        // When
        viewWillAppearTriger.onNext(true)
        // Then
        XCTAssertEqual(userDetailInteractorMock.getUserArg, "jvantuyl")
        XCTAssertEqual(output.userDetails.value?.id, userDetailsEntitySafe.id)
        XCTAssertEqual(output.userDetails.value?.login, userDetailsEntitySafe.login)
        
    }
    
}
