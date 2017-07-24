//
//  Sequence.swift
//  SwiftUtil
//
//  Created by Maximilian Schwenger on 24.07.17.
//

public extension Sequence where Iterator.Element: OptionalType {
    func flatten() -> [Iterator.Element.Wrapped] {
        return self.filter{ $0.optional != nil }.map{ $0.optional! }
    }
}


public extension Sequence {
    /*
     Split the given sequence into a satisfying (`t`) and a non-satisfying (`f`) part and
     returns both.
     */
    public func split(by pred: (Element) throws -> Bool) rethrows -> (t: [Element], f: [Element]) {
        return try self.reduce((t: [], f: []), { (accu, current) in
            if try pred(current) {
                return (accu.t + [current], accu.f)
            } else {
                return (accu.t, accu.f + [current])
            }
        })
    }
    
    /*
     Returns a dictionary mapping each available
     */
    public func classify<Kind>(by classify: (Element) throws -> Kind) rethrows -> [Kind:Element] {
        // Override duplicates! Check in seq2dict!
        // MultiMap maybe?
        let values: [(Kind, Element)] = try self.map{ (try classify($0), $0) }
        return seq2dict(tupleSeq: values)
    }
}
