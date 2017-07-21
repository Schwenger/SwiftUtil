//
//  MultiMap.swift
//  SwiftUtil
//
//  Created by Maximilian Schwenger on 21.06.17.
//

// TODO: Introduce removal operation.
public struct MultiMap<Key: Hashable, Coll: Collection> : Sequence  {
    
    public typealias Value = Coll.Element
    
    var dict: [Key: Coll]
    let empty: Coll
    let join: (Coll, Value) -> Coll
    
    public init(empty: Coll, join: @escaping (Coll, Value) -> Coll) {
        self.empty = empty
        self.dict = [Key: Coll]()
        self.join = join
    }
    
    public subscript(key: Key) -> Coll {
        get {
            return dict[key] ?? self.empty
        }
        set {
            self[key] = newValue
        }
    }
    
    /*
     Adds `val` to the collection associated with `key`.
     */
    public mutating func add(val: Value, to key: Key) {
        let coll = self[key]
        self[key] = self.join(coll, val)
    }
    
    /*
     Removes `key` from the map, and thus any reference to the collection it was
     formerly associated with.
     */
    public mutating func removeKey(key: Key) {
        dict.removeValue(forKey: key)
    }
    
    public func makeIterator() -> DictionaryIterator<Key,Coll> {
        return self.dict.makeIterator()
    }
    
}
