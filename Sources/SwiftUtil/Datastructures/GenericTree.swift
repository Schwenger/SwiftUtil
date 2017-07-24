//
//  GenericTree.swift
//  SwiftUtil
//
//  Created by Maximilian Schwenger on 24.07.17.
//

protocol GenericTree {
    var descend: [Self] { get }
}

extension GenericTree {
    
    public func linearize() -> [Self] {
        return self.flatMap{ $0 }
    }
    
    public func findFirst(satisfying pred: (Self) -> Bool) -> Self? {
        return self.linearize().findFirst(satisfying: pred)?.element
    }
    
    public func exists(_ pred: (Self) -> Bool) -> Bool {
        return self.findFirst(satisfying: pred) == nil
    }
    
    public func collect<R>(partialFn f: @escaping (Self) -> R?) -> [R] {
        return self.flatMap(f).filter{ $0 != nil }.map{ $0! }
    }
    
    public func flatMap<R>(_ f: @escaping (Self) -> R) -> [R] {
        return [f(self)] + self.descend.flatMap{ $0.flatMap(f) }
    }
    
    public func map<R: GenericTree>(_ f: @escaping (Self, [R]) -> R) -> R {
        return f(self, self.descend.map{ $0.map(f) })
    }
}
