//
//  Emptiable.swift
//  SwiftUtil
//
//  Created by Maximilian Schwenger on 16.07.17.
//

/// This type has a dedicated value representing the absence of a value.
public protocol Emptiable {
    static var empty: Self { get } 
}
