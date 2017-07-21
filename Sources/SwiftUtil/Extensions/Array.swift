//
//  Array.swift
//  Miscellaneous
//
//  Created by Maximilian Schwenger on 26.06.17.
//

public extension Array {
    
    /*
     Returns the `n`th from last element.
     Example:
         [1,2,3,4,5].fromLast(2) // 3
         [1,2,3,4,5].fromLast(3) // 2
         [1,2,3,4,5].fromLast(0) // 5
         [1,2,3,4,5].fromLast(5) // Runtime Error
         [1,2,3,4,5].fromLast(-1) // Runtime Error
     */
    public func fromLast(_ n: Int) -> Element {
        return self[self.endIndex - n - 1]
    }
    
    /*
     Finds the first `Element` satisfying the given predicate or `nil` if none exits.
     The respective `Element` and its Index are returned.
     */
    public func findFirst(satisfying pred: (Element) throws -> Bool) rethrows -> (element: Element, index: Index)? {
        for (ix, elem) in self.enumerated() {
            if try pred(elem) { return (elem, ix) }
        }
        return nil
    }
    
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
     Determines whether there exists at least one value satisfying the given predicate.
     */
    public func exists(_ pred: (Element) throws -> Bool) rethrows -> Bool {
        return try self.findFirst(satisfying: pred) != nil
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
