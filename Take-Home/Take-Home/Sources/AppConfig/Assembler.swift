//
//  Assembler.swift
//  Take-Home
//
//  Created by Van Thanh on 15/5/25.
//

import Foundation

protocol Assembler: AnyObject,
                        GithubUsersAssembler {}

final class DefaultAssembler: Assembler {}
