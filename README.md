# Awaitable

async/await for Swift

```swift
import Awaitable

func merge_sort<T : Comparable>(array: ArraySlice<T>) -> [T] {
  if array.count <= 16  { return Array(array).sort() }

  let mid = array.count / 2
  let left  = array[0..<mid]
  let right = array[mid..<array.count]

  let lf = async { merge_sort(left) }
  let lr = async { merge_sort(right) }

  return merge_sort(ArraySlice(lf.await() + lr.await()))
}

let v = merge_sort([10, 4, 5, 2, 100, 4, 3, 1, 88, 3])
print("result: \(v)")
// => result: [1, 2, 3, 3, 4, 4, 5, 10, 88, 100]
```

```swift
let t = async { () -> [() -> Int] in
  var a: [() -> Int] = []
  for i in 1...10000 {
    a.append({ i })
  }
  return a
}
let v = t.await().reduce(0) { $0 + $1 }

print("value: \(v)")
// => value: 50005000
```

# Links

- [A C#-style Async/Await implementation in Swift](https://gist.github.com/kylesluder/478bf8fd8232bc90eabd)
- [Implementing Async - Await / swift/docs/proposals](https://github.com/apple/swift/blob/master/docs/proposals/Concurrency.rst#implementing-async---await)

# License

MIT
