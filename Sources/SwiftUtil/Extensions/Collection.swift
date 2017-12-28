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
   Finds the first `Element` and its index satisfying the given predicate or `nil` if none exits.
   The respective `Element` and its Index are returned.
   */
  public func findFirst(satisfying pred: (Element) throws -> Bool) rethrows -> (element: Element, index: Index)? {
    var ix = self.startIndex
    for elem in self {
      if try pred(elem) {
        return (elem, ix)
      }
      ix = self.index(ix, offsetBy: 1)
    }
    return nil
  }

  /*
   Determines whether there exists at least one value satisfying the given predicate.
   */
  public func exists(_ pred: (Element) throws -> Bool) rethrows -> Bool {
    return try self.findFirst(satisfying: pred) != nil
  }

  /*
   Determines whether all elements satisfy a given predicate.
   */
  public func forall(_ pred: (Element) throws -> Bool) rethrows -> Bool {
    return try self.reduce(true, { (accu, element) in try accu && pred(element) })
  }

}

extension Collection where Element == Bool {
  public var and: Bool { return self.forall{ $0 } }
  public var or: Bool { return self.exists{ $0 } }
}

