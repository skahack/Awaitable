import Dispatch

let defaultQueue: dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

public struct Await<T> {
  private let getResult: () -> T
  public func await() -> T { return getResult() }
}

public func async<T>(queue: dispatch_queue_t = defaultQueue, block: () -> T) -> Await<T> {
  let group = dispatch_group_create()
  var result: T?

  dispatch_group_async(group, queue) { result = block() }

  return Await(getResult: { dispatch_group_wait(group, DISPATCH_TIME_FOREVER); return result! })
}

public func async<T>(queue: dispatch_queue_t = defaultQueue, block: () -> [() -> T]) -> Await<[T]> {
  let group = dispatch_group_create()
  let lock = dispatch_semaphore_create(1)
  var results: Dictionary<Int, T> = [:]

  for (k, v) in block().enumerated() {
    dispatch_group_async(group, queue) {
      let res = v()
      dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
      results[k] = res
      dispatch_semaphore_signal(lock);
    }
  }

  return Await(getResult: { () -> [T] in
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
    return Array(results.values)
  })
}
