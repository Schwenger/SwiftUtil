//
//  Util.swift
//  SwiftUtil
//
//  Created by Maximilian Schwenger on 23.06.17.
//
    
infix operator ==?: ComparisonPrecedence
public func ==?<T: Equatable> (lhs: T?, rhs: T?) -> Bool {
  if let lhs = lhs, let rhs = rhs {
    return lhs == rhs
  } else {
    return lhs == nil && rhs == nil
  }
}

prefix operator ☠
public prefix func ☠(_ message: String = "") -> Never {
  fatalError(message)
}

func mod(_ a: Int, _ n: Int) -> Int {
    precondition(n > 0, "modulus must be positive")
    let r = a % n
    return r >= 0 ? r : r + n
}

public func memoize<A:Hashable, R>(_ fn : @escaping (A) -> R) -> (A) -> R {
  var cache = [A:R]()
  return {
    (arg : A) -> R in
    if cache[arg] == nil {
      cache[arg] = fn(arg)
    }
    return cache[arg]!
  }
}

// Probably pointless, because it can always(?) be replaced by a lazy variable.
public func memoizeSingle<T>(_ provider : @escaping () -> T) -> () -> T {
  var cache: T?
  return {
    if cache == nil {
      cache = provider()
    }
    return cache!
  }
}

public func collectDescending<T>(origin: T, descend desc: @escaping (T) -> [T]) -> [T] {
  return descendingFlatMap(origin: origin, map: {$0}, descend: desc)
}

public func descendingFlatMap<T,R>(origin: T, map: @escaping (T) -> R , descend desc: @escaping (T) -> [T]) -> [R] {
  func collect(_ elem: T) -> [R] {
    return [map(elem)] + desc(elem).flatMap(collect)
  }
  return collect(origin)
}

public func seq2dict<Key,Value>(tupleSeq: [(Key, Value)]) -> [Key:Value] {
    var res = [Key:Value]()
    tupleSeq.forEach{ res[$0.0] = $0.1 }
    return res
}

// TODO: More polymorph
infix operator >>°: BitwiseShiftPrecedence
public func >>°(bits: Int, k: Int) -> Int {
  let size = MemoryLayout<Int>.size
  return (bits >> k) | (bits << (size - k));
}

public extension Optional {
  public var empty: Bool { get {
    switch self {
    case .none: return true
    case .some: return false
    }}
  }
}

protocol GenericTree {
    var descend: [Self] { get }
}

extension GenericTree {
    public func linearMap<R>(_ map: @escaping (Self) -> R) -> [R] {
        return self.linearized.map(map)
    }
    
    public var linearized: [Self] { get { return [self] + self.descend.flatMap{ $0.linearized } } }
    
    public func exists(_ pred: @escaping (Self) -> Bool) -> Bool {
        return self.linearized.findFirst(satisfying: pred) == nil
    }
    
    public func collect<R>(partialFn f: @escaping (Self) -> R?) -> [R] {
        return self.linearMap(f).filter{ $0 != nil }.map{ $0! } // There has to be a prettier way...
    }
}

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
