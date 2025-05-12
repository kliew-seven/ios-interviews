import Combine
import Foundation

/// Combine solution
func searchPublisherSol(for textPublisher: AnyPublisher<String, Never>) -> AnyPublisher<[Title], Never> {
    textPublisher
        .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
        .removeDuplicates()
        .flatMapLatest { query in
            performSearch(query: query)
        }
        .eraseToAnyPublisher()
}

// Helper extension for flatMapLatest (Combine doesn't have it built-in)
extension Publisher {
    func flatMapLatest<T: Publisher>(_ transform: @escaping (Output) -> T)
        -> Publishers.SwitchToLatest<T, Publishers.Map<Self, T>> where T.Failure == Failure
    {
        map(transform).switchToLatest()
    }
}

/// RxSwift solution
// func searchObservable(for textObservable: Observable<String>) -> Observable<[Title]> {
//     textObservable
//         .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
//         .distinctUntilChanged()
//         .flatMapLatest { query in
//             performSearch(query: query)
//         }
// }

/// Async stream solution
// func searchTaskStream(for textStream: AsyncStream<String>) -> AsyncStream<[Title]> {
//    AsyncStream { continuation in
//        Task {
//            var latestQuery = ""
//            var searchTask: Task<Void, Never>?
//
//            for await query in textStream {
//                latestQuery = query
//
//                // Cancel previous search
//                searchTask?.cancel()
//
//                // Debounce 300ms
//                try? await Task.sleep(nanoseconds: 300 * 1_000_000)
//
//                // Cancelled? Skip
//                guard !Task.isCancelled else { continue }
//
//                // Capture query to avoid race with newer input
//                let queryAtStart = latestQuery
//                searchTask = Task {
//                    let results = await performSearch(query: queryAtStart)
//                    continuation.yield(results)
//                }
//            }
//
//            continuation.finish()
//        }
//    }
// }
