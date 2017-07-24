//
//  Collection.swift
//  SwiftUtil
//
//  Created by Maximilian Schwenger on 16.07.17.
//

public extension Collection {
    /* Rename for the existing `first` property. */
    public var head: Element? {
        get {
            return self.first
        }
    }
    
    /*
     Returns `nil` if the collection is empty.
     Otherwise returns a copy less the first element, potentially the empty collection.
     */
    public var tail: Array<Element>? {
        if self.isEmpty {
            return nil
        } else {
            return Array(self.dropFirst())
        }
    }
    
    /*
     Returns a dictionary mapping each available
     */
    public func classify<Kind>(by classify: (Element) throws -> Kind) rethrows -> [Kind:Element] {
        // Override duplicates! Check in seq2dict!
        // MultiMap maybe?
        // TODO!!
        let values: [(Kind, Element)] = try self.map{ (try classify($0), $0) }
        return seq2dict(tupleSeq: values)
    }
}
