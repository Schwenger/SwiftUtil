//
//  Math.swift
//  SwiftUtil
//
//  Created by Maximilian Schwenger on 24.07.17.
//

func cartesianProduct<T>(vectors: [[T]]) -> [[T]] {
    func progress(yvec: [[T]], xvec: [T]) -> [[T]] {
        return xvec.map{ (xelem: T) in
            yvec.map{ (yelem: [T]) in
                [xelem] + yelem
            }
            }.reduce([[T]](), +)
    }
    guard let head = vectors.head, let tail = vectors.tail else {
        return vectors
    }
    return tail.reduce(head.map{[$0]}, progress(yvec:xvec:))
}

public func mod(_ a: Int, _ n: Int) -> Int {
    precondition(n > 0, "modulus must be positive")
    let r = a % n
    return r >= 0 ? r : r + n
}
