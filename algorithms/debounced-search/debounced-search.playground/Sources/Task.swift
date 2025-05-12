import Combine
import Foundation

public struct Title: Equatable {
    let name: String
}

// Simulate a networked search API call with IO delay
public func performSearch(query: String) -> AnyPublisher<[Title], Never> {
    Just([Title(name: "Result for \(query)")])
        .delay(for: .milliseconds(200), scheduler: DispatchQueue.global())
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
}

public func searchPublisher(for _: AnyPublisher<String, Never>) ->
    AnyPublisher<[Title], Never>
{
    // TODO: Implement your function to return a publisher that emits the search results
    return Empty().eraseToAnyPublisher()
}
