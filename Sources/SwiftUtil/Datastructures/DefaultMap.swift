////
////  DefaultMap.swift
////  Lola
////
////  Created by Maximilian Schwenger on 23.06.17.
////
//
//// This shoudld probably inherit from collection.
//public class DefaultMap<K: Hashable, V> : Collection {
//    public typealias _Element = <#type#>
//
//    public typealias SubSequence = <#type#>
//
//
//    public init(dft: VdictionaryLiteral elements: (K, V)...) {
//        self.dict = seq2dict(tupleSeq: elements)
//    }
//
//    public typealias Index = Dictionary<K, V>.Index
//
//    /// - the `startIndex` and `endIndex` properties,
//    /// - a subscript that provides at least read-only access to your type's
//    ///   elements, and
//    /// - the `index(after:)` method for advancing an index into your collection.
//
//    public var startIndex: Index { get { return self.dict.startIndex } }
//    public var endIndex: Index { get { return self.dict.endIndex } }
//    public func index(after: Index) -> Index { return self.dict.index(after: after) }
//    
//    public typealias Key = K
//
//    public typealias Value = V
//
//
//    public typealias Element = Value
//
//    var dict: Dictionary<Key,Value> = [:]
//    let dft: Value
//
//    public subscript(key: Key) -> Value {
//        get {
//            return self.dict[key] ?? Value.empty
//        }
//
//        set(value) {
//            return self.dict[key] = value
//        }
//    }
////
////    public func get(key: Key) -> Value {
////        return dict[key] ?? dft()
////    }
////
////    public func removeKey(key: Key) {
////        dict.removeValue(forKey: key)
////    }
////
////    public func set(key: Key, val: Value) {
////        dict[key] = val
////    }
////
////    public func makeIterator() -> DictionaryIterator<Key,Value> {
////        return dict.makeIterator()
////    }
//
//}

