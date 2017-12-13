//
//  Util.swift
//  SwiftUtil
//
//  Created by Maximilian Schwenger on 23.06.17.
//

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

/*
 Generates a sequence of elements generated by calling `generator` repeatedly until `stopWhen` is `true` for a generated
 pivot element. The pivot is included iff `includePivot` is `true`.
 */
public func yield<T>(_ generator: () throws -> T, stopWhen pred: (T) throws -> Bool, includePivot: Bool = false) rethrows -> [T] {
    var res = [T]()
    while true {
        let next = try generator()
        if try pred(next) {
            if includePivot {
                res.append(next)
            }
            return res
        }
        res.append(next)
    }
}

public func yield<T: OptionalType>(_ generator: () throws -> T) rethrows -> [T.Wrapped] {
    let res: [T] = try yield(generator, stopWhen: { $0.optional.empty }, includePivot: false)
    return res.flattened
}
