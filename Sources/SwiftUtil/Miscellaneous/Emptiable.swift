//
//  Emptiable.swift
//  SwiftUtil
//
//  Created by Maximilian Schwenger on 16.07.17.
//

/*
 Specifies values that have a class/struct-unique empty value.
 */
public protocol Emptiable {
    static var empty: Self { get } 
}
