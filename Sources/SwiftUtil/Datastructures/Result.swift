//
//  Result.swift
//  SwiftUtil
//
//  Created by Maximilian Schwenger on 16.07.17.
//

/// Represents the result of an operation. Either it was a success or a failure.
/// In any case, endeavours of recovery and processing can be performed.
public enum Result<Captured>: Sequence, RepresentableAsOpt {
    case Success(value: Captured)
    case Failure
    
    public typealias Element = Captured
    
    /*
     Initializer for a `Result`. If the experiments succedes, a `.Success` is returned.
     Otherwise, the failure is hidden into a `.Failure`.
     */
    public static func trySomething(_ experiment: () throws -> Captured) -> Result<Captured> {
        if let value = try? experiment() {
            return .Success(value: value)
        } else {
            return .Failure
        }
    }
    
    public var opt: Captured? {
        switch self {
            case .Success(let value): return value
            case .Failure: return nil
        }
    }
    
    private static func fromOpt(_ optVal: Captured?) -> Result<Captured> {
        if let val = optVal {
            return .Success(value: val)
        } else {
            return .Failure
        }
    }
    
    public func makeIterator() -> ResultIterator<Captured> {
        return ResultIterator(self)
    }
    
    /*
     If this `Result` is a `.Failure`, it returns a `.Success` with the value obtained by
     the recover action. Otherwise, this function will return the identity.
     */
    public func recover(_ f: () -> Captured) -> Result<Captured> {
        switch self {
        case .Success: return self
        case .Failure: return .Success(value: f())
        }
    }
    
    /*
     If this `Result` is a `.Success`, this function will return the identity.
     Otherwise, another attempt of obtaining a value is undertaken using the
     recover function.
     */
    public func tryRecover(_ f: () throws -> Captured) -> Result<Captured> {
        switch self {
        case .Success: return self
        case .Failure: return Result.trySomething(f)
        }
    }
    
    /*
     If the result is a `.Success`, the passed function is applied on the captured value,
     again resulting in a `Result`.
     Otherwise , the identity is returned.
     */
    public func map<Other>(_ f: @escaping (Captured) throws -> Other) -> Result<Other> {
        switch self {
        case .Success(let value): return Result<Other>.fromOpt(try? f(value))
        case .Failure: return Result<Other>.Failure
        }
    }
    
}

// This seems unnecessarily clunky.
public struct ResultIterator<Captured>: IteratorProtocol {
    let result: Result<Captured>
    private var unused: Bool = true
    
    fileprivate init(_ result: Result<Captured>) {
        self.result = result
    }
        
    public mutating func next() -> Captured? {
        if unused {
            unused = false
            return result.opt
        } else {
            return nil
        }
    }
}
