//
//  ViewModelType.swift
//  Take-Home
//
//  Created by Van Thanh on 15/5/25.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
