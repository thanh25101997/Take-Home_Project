//
//  UserDetailRepositoryTest.swift
//  Take-Home
//
//  Created by Van Thanh on 21/5/25.
//

import XCTest
import RxSwift
@testable import Take_Home

final class UserDetailRepositoryTest: XCTestCase {
    
    // Target
    var repository: UserDetailRepository!
    // Mock
    var apiClientMock: APIClientMock!
    
    override func setUp() {
        super.setUp()
        apiClientMock = APIClientMock()
        repository = UserDetailRepository(apiClient: apiClientMock)
    }
    
    /// ## testGetUserFromServer
    /// ## [prerequisites]
    /// intputLoginUserName
    ///## [Expected result]
    /// apiClientMock.endPointArg
    func testGetUserFromServer() {
        // Given
        let intputLoginUserName = "vanthanh"
        // When
        _ = repository.getUserFromServer(loginUserName: intputLoginUserName)
        // Then
        XCTAssertEqual(apiClientMock.endPointArg?.baseUrl, "https://api.github.com/")
        XCTAssertEqual(apiClientMock.endPointArg?.endPoint, "users/" + intputLoginUserName)
        XCTAssertEqual(apiClientMock.endPointArg?.method, .get)
    }
    
}
