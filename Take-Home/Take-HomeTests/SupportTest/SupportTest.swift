//
//  supportTest.swift
//  Take-Home
//
//  Created by Van Thanh on 19/5/25.
//

import XCTest

extension XCTestCase {
    
    func runWithParams<T>(params: [T],
                          block: ((Int, T)->())) {
        params.enumerated().forEach { index, paramElement in
            XCTContext.runActivity(named: "\(#function)_\(index)") { activity in
                setUp()
                block(index, paramElement)
                tearDown()
            }
        }
    }
    
}


