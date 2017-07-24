# SwiftUtil
This library intents to provide useful functionality for common tasks. It does so by implementing new data structures for recurring tasks, extending existing ones, or providing new general-purpose functions.

## Datastructures
### Either 
`Either` represents an unresolved case split. The type of the stored data is unknown but can be manipulated in a pipeline. Hereby, only one side can be processed disregading the other, or the operation can be twofold, allowing to process either side.

The overall purpose is to defer resolving the outcome of the case split as long as possible allowing for a clean pipeline. It should not, however, be used as a replacement of `if` statements with long and structurally different cases.

### Result
`Result` wrapps the result of a potentially failing action. It stores the action's result in case of a success, or the thrown error. It provides the option to recover by performing an alternative action. By acting as a `Sequence` and an `Optional`, it can be integrated in a pipelining structure neatly.

### MultiMap
*Caution: As of now, the exact details of this structure are a little fuzzy and might be counter-intuitive.*

`MultiMap` allows to map a key on a colletion of values. Therefore, functions as a dictionary mapping a `Key` to a `Collection` and serves reduces the necessity of maintaning the collection by hand.

### CyclicBuffer
`CyclicBuffer` is a fixed-size array. All entries are initialized with a default value. New values are added in a cyclic fashing, first overwriting default values, then overwriting the last added entry. Accesses will be relative to the buffers head, which is not necessarily its end.

### DynamicallyIterableOrderedSequence (DIOS)
`DIOS` is a ordered collection of values. During an iteration process, values may be added to the collection. If they are greater than the iterator's current head, the iterator's behavior is equivalent to the behavior when adding the element before the iteration starts. If the value is less, then the iterator's behavior is equivalent to when the element has not been added at all.

### GenericTree
The `GenericTree` protocol requires an accessor for decendents. This way, useful general-purpose tree functionality is provided including functions used for sequences, e.g. `map`.

## Extensions
The extensions to existing data structures are rather limited only supplying often-used functions e.g. for finding elements or partitioning collections.

## Miscellaneous
### Protocols
Provides small protocols that can be used to specify common accessor features.
### Math
Provides commonly used math functions like `mod(Int:Int:)` and `cartesianProduct([[T]]:)`.
### Util
Provides general functionality like the unary operator `☠(String:)` to mark problematic regions in the code like ToDos.
