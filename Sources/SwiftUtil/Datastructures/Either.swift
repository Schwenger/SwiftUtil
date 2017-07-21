//
//  Either.swift
//  SwiftUtil
//
//  Created by Maximilian Schwenger on 21.06.17.
//

public enum Either<A,B> {
  case Left(A)
  case Right(B)
    
  public func getSuccess() -> A? {
    switch self {
    case .Left(let item):
      return item
    case .Right(_):
      return nil
    }
  }
  
  public func getFailure() -> B? {
    switch self {
    case .Left(_):
      return nil
    case .Right(let item):
      return item
    }
  }
  
  public func map<C,D> (success s: (A) -> C, failure f: (B) -> D) -> Either<C,D> {
    switch self {
    case .Left(let item):
      return .Left(s(item))
    case .Right(let item):
      return .Right(f(item))
    }
  }
  
  public func successmap<C> (_ s: (A) -> C) -> Either<C,B> {
    switch self {
    case .Left(let item):
      return .Left(s(item))
    case .Right(let item):
      return .Right(item)
    }
  }
  
  public func failmap<C> (_ f: (B) -> C) -> Either<A,C> {
    switch self {
    case .Left(let item):
      return .Left(item)
    case .Right(let item):
      return .Right(f(item))
    }
  }
  
  public func successflatmap<C> (_ s: (A) -> C) -> C? {
    switch self {
    case .Left(let item):
      return s(item)
    case .Right(_):
      return nil
    }
  }
  
  public func failflatmap<C> (_ f: (B) -> C) -> C? {
    switch self {
    case .Left(_):
      return nil
    case .Right(let item):
      return f(item)
    }
  }
}
