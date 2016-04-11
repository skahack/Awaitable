# Awaitable

async/await for Swift

```swift
import Awaitable

func merge_sort<T : Comparable>(array: Array<T>) -> [T] {
  if array.count <= 16  { return array.sort() }

  let mid = array.count / 2
  let left  = Array(array[0..<mid])
  let right = Array(array[mid..<array.count])

  let lf = async { merge_sort(left) }
  let lr = async { merge_sort(right) }

  return (lf.await() + lr.await()).sort()
}

let a = [
  28, 87, 98, 16, 25,
  24, 88, 74, 82, 18,
  69, 53, 0,  86, 4,
  81, 54, 60, 64, 12,
  53, 3,  39, 78, 99]

let v = merge_sort(a)
print("result: \(v)")
// => result: [0, 3, 4, 12, 16, 18, 24, 25, 28, 39, 53, 53, 54, 60, 64, 69, 74, 78, 81, 82, 86, 87, 88, 98, 99]
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
