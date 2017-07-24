//
//  Optional.swift
//  SwiftUtil
//
//  Created by Maximilian Schwenger on 24.07.17.
//

extension Optional {
    func getOrElse(_ gen: () -> Wrapped) -> Wrapped {
        switch self {
        case .some(let content): return content
        case .none: return gen()
        }
    }
}
