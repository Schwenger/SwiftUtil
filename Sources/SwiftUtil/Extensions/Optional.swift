//
//  Optional.swift
//  SwiftUtil
//
//  Created by Maximilian Schwenger on 24.07.17.
//

public extension Optional {
    func getOrElse(_ gen: () -> Wrapped) -> Wrapped {
        switch self {
        case .some(let content): return content
        case .none: return gen()
        }
    }
    
    public var empty: Bool { get {
        switch self {
        case .none: return true
        case .some: return false
        }}
    }
}

// Allows extending datastructures with associated optional type.
// Thanks to https://stackoverflow.com/questions/33138712/function-arrayoptionalt-optionalarrayt
public protocol OptionalType {
    associatedtype Wrapped
    var optional: Wrapped? { get }
}

extension Optional: OptionalType {
    public var optional: Wrapped? { return self }
}

infix operator ==?: ComparisonPrecedence
public func ==?<T: Equatable> (lhs: T?, rhs: T?) -> Bool {
    if let lhs = lhs, let rhs = rhs {
        return lhs == rhs
    } else {
        return lhs == nil && rhs == nil
    }
}
