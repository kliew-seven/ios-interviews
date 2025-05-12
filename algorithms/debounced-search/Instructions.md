## Debounced Search

### Scenario

<img src="assets/search.png" width="250"/>

You're implementing 7plus's search functionality for video titles. As the user types in the search input, you want to:

- **Debounce** the input (wait ≥300ms since the last interaction before triggering a search)
- **Cancel any in-flight search** if a new input arrives
- **Only emit the latest result**

### Option 1: Combine

Write a function that takes a `Publisher<String, Never>` (user input stream) and returns a `Publisher<[Title], Never>` (search results stream):

```swift
import Combine

struct Title: Equatable {
    let name: String
}

func performSearch(query: String) -> AnyPublisher<[Title], Never> {
    // Fake API call
    Just([Title(name: "Result for \(query)")])
        .delay(for: .milliseconds(200), scheduler: RunLoop.main)
        .eraseToAnyPublisher()
}

func searchPublisher(for textPublisher: AnyPublisher<String, Never>) -> AnyPublisher<[Title], Never> {
    // Your implementation
}
```

### Option 2: RxSwift

Write a function that takes an `Observable<String>` (user input stream) and returns an `Observable<[Title]>` (search results stream):

```swift
import RxSwift

struct Title: Equatable {
    let name: String
}

func performSearch(query: String) -> Observable<[Title]> {
    // Fake API call
    return Observable.just([Title(name: "Result for \(query)")])
        .delay(.milliseconds(200), scheduler: MainScheduler.instance)
}

func searchObservable(for textObservable: Observable<String>) -> Observable<[Title]> {
    // Your implementation
}
```

### Option 3: AsyncStream

Write a function that takes an `AsyncStream<String>` (user input stream) and returns an `AsyncStream<[Title]>` (search results stream):

```swift
struct Title: Equatable {
    let name: String
}

func performSearch(query: String) async -> [Title] {
    // Fake API call
    await Task.sleep(200 * 1_000_000) // 200ms
    return [Title(name: "Result for \(query)")]
}

func searchTaskStream(for textStream: AsyncStream<String>) -> AsyncStream<[Title]> {
    // Your implementation
}
```