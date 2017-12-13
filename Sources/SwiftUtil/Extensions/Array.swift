//
//  Array.swift
//  Miscellaneous
//
//  Created by Maximilian Schwenger on 26.06.17.
//

public extension Array {
    
    /*
     Returns the `n`th from last element.
     Example:
         [1,2,3,4,5].fromLast(2) // 3
         [1,2,3,4,5].fromLast(3) // 2
         [1,2,3,4,5].fromLast(0) // 5
         [1,2,3,4,5].fromLast(5) // Runtime Error
         [1,2,3,4,5].fromLast(-1) // Runtime Error
     */
    public func fromLast(_ n: Int) -> Element {
        return self[self.endIndex - n - 1]
    }
    
}
