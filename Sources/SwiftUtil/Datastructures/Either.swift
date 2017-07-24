//
//  Either.swift
//  SwiftUtil
//
//  Created by Maximilian Schwenger on 21.06.17.
//

public enum Either<A,B> {
  case Left(A)
  case Right(B)
    
  public func getLeft() -> A? {
    switch self {
    case .Left(let item):
      return item
    case .Right(_):
      return nil
    }
  }
  
  public func getRight() -> B? {
    switch self {
    case .Left(_):
      return nil
    case .Right(let item):
      return item
    }
  }
  
  public func map<C,D> (left: (A) -> C, right: (B) -> D) -> Either<C,D> {
    switch self {
    case .Left(let item):
      return .Left(left(item))
    case .Right(let item):
      return .Right(right(item))
    }
  }
  
  public func successmap<C> (_ leftMap: (A) -> C) -> Either<C,B> {
    switch self {
    case .Left(let item):
      return .Left(leftMap(item))
    case .Right(let item):
      return .Right(item)
    }
  }
  
  public func failmap<C> (_ rightMap: (B) -> C) -> Either<A,C> {
    switch self {
    case .Left(let item):
      return .Left(item)
    case .Right(let item):
      return .Right(rightMap(item))
    }
  }
  
  public func leftFlatMap<C> (_ leftMap: (A) -> C) -> C? {
    switch self {
    case .Left(let item):
      return leftMap(item)
    case .Right(_):
      return nil
    }
  }
  
  public func rightFlatMap<C> (_ rightMap: (B) -> C) -> C? {
    switch self {
    case .Left(_):
      return nil
    case .Right(let item):
      return rightMap(item)
    }
  }
}
