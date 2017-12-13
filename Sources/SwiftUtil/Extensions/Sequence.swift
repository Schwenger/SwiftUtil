//
//  Sequence.swift
//  SwiftUtil
//
//  Created by Maximilian Schwenger on 24.07.17.
//

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

  public func zipWith<T>(_ map: (Iterator.Element) -> T) -> [(Iterator.Element, T)] {
    return self.map{ ($0, map($0))}
  }
}

public extension Sequence where Iterator.Element: OptionalType {
  /*
   Array containing the content of all non-empty elements. `nil` are removed.
   Example: [Some(1), Some(4), nil, Some(3)].flattened == [1,4,3]
  */
  public var flattened: [Iterator.Element.Wrapped] {
    return self.filter{ $0.optional != nil }.map{ $0.optional! }
  }
}

public extension Sequence where Iterator.Element: Collection {
  /*
   Array containing the order-preserving union of all elements.
   Example: [[2,3], [1,9]].joined == [2,3,1,9]
  */
  public var joined: [Iterator.Element.Element] {
    return self.reduce([],+)
  }
}
