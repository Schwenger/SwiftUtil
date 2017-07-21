//
//  DynamicallyIterableSortedSequence.swift
//  SwiftUtil
//
//  Created by Maximilian Schwenger on 13.07.17.
//

public typealias DIOS<T> = DynamicallyIterableOrderedSequence<T>

/// DynamicallyIterableOrderedSequence
/// This class is an `<`-order sequence allowing to alter the sequence while iterating.
/// The iteration will take dynamically inserted values into account unless the iteration
/// already passed the index of the newly added values. The iteration and insertion
/// indices are determined based on `<`.
/// Each instance of this class can be iterated only once unless `resetIterator` is called.
public struct DynamicallyIterableOrderedSequence<T>: Sequence, IteratorProtocol {
    
    public let less: (T,T) -> Bool
    private var values: [T]
    private var state = 0
    
    public init(_ values: [T], less: @escaping (T,T) -> Bool) {
        self.less = less
        self.values = values.sorted(by: less)
    }
    
    public init(less: @escaping (T,T) -> Bool) {
        self.init([], less: less)
    }
    
    /*
     Adds an element to the sequence. The resulting index is determined by `less`.
     When an iteration is in progress and the last call to `next()` did return a values
     that is less according to `less`, the new values will be subject of said iteration.
     */
    public static func +=(dios: inout DIOS<T>, new: T) {
        if let desiredIndex = dios.values.findFirst(satisfying: { dios.less(new, $0 ) })?.index {
            assert(desiredIndex >= dios.state) // This would mean a violation of the evaluation order contract.
            dios.values.insert(new, at: desiredIndex)
        } else {
            dios.values.append(new)
            return
        }
    }
    
    /*
     Adds an array of elements to the sequence. For each element separately, the rules of
     `+=` apply.
     */
    public static func +=(dios: inout DIOS<T>, newValues: [T]) {
        for new in newValues {
            dios += new
        }
    }
    
    /*
     Returns the next element with respect to `less`.
     */
    public mutating func next() -> T? {
        if state < values.count {
            state += 1
            return values[state - 1]
        } else {
            return nil
        }
    }
    
    /*
     Resets the iterator allowing another iteration of this instance.
     */
    public mutating func resetIterator() {
        self.state = 0
    }
    
}

public extension DIOS where T: Comparable {
    public init(_ values: [T]) {
        self.init(values, less: { $0 < $1 })
    }
    
    public init() {
        self.init([])
    }
}
