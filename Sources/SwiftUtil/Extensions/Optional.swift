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

public extension Optional where Wrapped: Numeric {
   // All those functions also work for an unwrapped Numeric as left operand due to implicit conversion of Optionals.
    static func +?(_ left: Optional<Wrapped>, right: Optional<Wrapped>) -> Optional<Wrapped> {
        if left.empty || right.empty { return nil }
        else { return left! + right! }
    }
    static func -?(_ left: Optional<Wrapped>, right: Optional<Wrapped>) -> Optional<Wrapped> {
        if left.empty || right.empty { return nil }
        else { return left! - right! }
    }
    static func *?(_ left: Optional<Wrapped>, right: Optional<Wrapped>) -> Optional<Wrapped> {
        if left.empty || right.empty { return nil }
        else { return left! * right! }
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

public func ==?<T: Equatable> (lhs: T?, rhs: T?) -> Bool {
    if let lhs = lhs, let rhs = rhs {
        return lhs == rhs
    } else {
        return lhs == nil && rhs == nil
    }
}
