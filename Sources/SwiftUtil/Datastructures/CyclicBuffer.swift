//
//  CyclicBuffer.swift
//  SwiftUtil
//
//  Created by Maximilian Schwenger on 14.07.17.
//


// TODO: This is a BidirectionalCollection
/*
 A collection storing a fixed number of values.
 */
public struct CyclicBuffer<Element> {
    
    public let size: Int
    private var values: [Element]
    private var nextFree: Int
    
    public var last: Element { get { return self.getRelative(withOffset: 0) } }
    
    init(size: Int, empty: Element) {
        self.size = size
        self.values = [Element](repeating: empty, count: size)
        self.nextFree = 0
    }
    
    private func getIx(_ offset: Int) -> Int {
        return mod(nextFree - 1 + offset, self.size)
    }
    
    public func getRelative(withOffset offset: Int) -> Element {
        return values[getIx(offset)]
    }
    
    public mutating func replaceLast(by val: Element) {
        self.values[getIx(0)] = val
    }
    
    public static func +=(buffer: inout CyclicBuffer<Element>, elem: Element) {
        buffer.values[buffer.getIx(1)] = elem
        buffer.nextFree += 1
    }
    
}

public extension CyclicBuffer where Element: Emptiable {
    init(size: Int) {
        self.init(size: size, empty: Element.empty)
    }
}




