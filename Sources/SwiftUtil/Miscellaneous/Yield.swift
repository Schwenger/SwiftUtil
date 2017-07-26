//
//  Yield.swift
//  SwiftUtil
//
//  Created by Maximilian Schwenger on 26.07.17.
//

public struct Yield<T> {
    private let generator: () -> T
    
    public init(_ f: @escaping () -> T) {
        self.generator = f
    }
    
    public func until(_ pred: (T) -> Bool) -> [T] {
        var res = [T]()
        var cont = true
        while cont {
            res.append(generator())
            cont = pred(res.head!)
        }
        return res
    }
}
