//
//  Util.swift
//  SwiftUtil
//
//  Created by Maximilian Schwenger on 23.06.17.
//

prefix operator ☠
public prefix func ☠(_ message: String = "") -> Never {
  fatalError(message)
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

public func seq2dict<Key,Value>(tupleSeq: [(Key, Value)]) -> [Key:Value] {
    // ☠ Overwrites duplicates silently!
    var res = [Key:Value]()
    tupleSeq.forEach{ res[$0.0] = $0.1 }
    return res
}

public func yield<T>(_ generator: () throws -> T, until pred: (T) throws -> Bool) rethrows -> [T] {
    var res = [T]()
    var cont = true
    while cont {
        res.append(try generator())
        cont = try pred(res.head!)
    }
    return res
}

public func yield<T: OptionalType>(_ generator: () throws -> T) rethrows -> [T.Wrapped] {
    let res: [T] = try yield(generator, until: { $0.optional.empty })
    return res.flatten()
}
