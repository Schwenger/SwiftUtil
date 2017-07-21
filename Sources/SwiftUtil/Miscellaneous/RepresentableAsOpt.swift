//
//  RepresentableAsOpt.swift
//  Miscellaneous
//
//  Created by Maximilian Schwenger on 16.07.17.
//

/*
 Defines values that might or might not yield a value and can thus
 be represented as an optional value. This operation should not lead to
 a loss of information. The complexity should be O(1), any implementation
 deviating from this complexity should explicitly mention it.
 */
public protocol RepresentableAsOpt {
    associatedtype Element
    var opt: Element? { get }
}
