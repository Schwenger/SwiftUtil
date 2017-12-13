//
//  Either.swift
//  SwiftUtil
//
//  Created by Maximilian Schwenger on 21.06.17.
//

public enum Either<L,R> {

  case Left(L)
  case Right(R)
    
  public func getLeft() -> L? {
    switch self {
    case .Left(let item):
      return item
    case .Right(_):
      return nil
    }
  }
  
  public func getRight() -> R? {
    switch self {
    case .Left(_):
      return nil
    case .Right(let item):
      return item
    }
  }
  
  public func map<C,D> (left: (L) -> C, right: (R) -> D) -> Either<C,D> {
    switch self {
    case .Left(let item):
      return .Left(left(item))
    case .Right(let item):
      return .Right(right(item))
    }
  }
  
  public func leftmap<C> (_ leftMap: (L) -> C) -> Either<C,R> {
    switch self {
    case .Left(let item):
      return .Left(leftMap(item))
    case .Right(let item):
      return .Right(item)
    }
  }
  
  public func rightmap<C> (_ rightMap: (R) -> C) -> Either<L,C> {
    switch self {
    case .Left(let item):
      return .Left(item)
    case .Right(let item):
      return .Right(rightMap(item))
    }
  }
  
  public func leftFlatMap<C> (_ leftMap: (L) -> C) -> C? {
    switch self {
    case .Left(let item):
      return leftMap(item)
    case .Right(_):
      return nil
    }
  }
  
  public func rightFlatMap<C> (_ rightMap: (R) -> C) -> C? {
    switch self {
    case .Left(_):
      return nil
    case .Right(let item):
      return rightMap(item)
    }
  }
}
