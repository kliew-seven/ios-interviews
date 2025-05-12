import Combine
import Foundation
import XCTest

public final class DebouncedSearchCompleteTestSuite: XCTestSuite {
    public init() {
        super.init(name: "DebouncedSearchCompleteTestSuite")
        addTest(DebouncedSearchTests.defaultTestSuite)
    }
}

final class DebouncedSearchTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []

    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
    }

    @MainActor
    func testDebounceAndLatestResult() {
        let expectation = XCTestExpectation(
            description: "Should emit only the latest debounced result"
        )
        let subject = PassthroughSubject<String, Never>()
        var results: [[Title]] = []

        let publisher = searchPublisher(for: subject.eraseToAnyPublisher())
        publisher
            .sink { value in
                results.append(value)
                if results.count == 1 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        subject.send("a")
        subject.send("ab")
        subject.send("abc")

        // Only the last value after debounce should trigger a search
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            subject.send(completion: .finished)
        }

        wait(for: [expectation], timeout: 2.0)
        XCTAssertEqual(results, [[Title(name: "Result for abc")]])
    }

    @MainActor
    func testCancelInFlightSearch() {
        let expectation = XCTestExpectation(
            description: "Should cancel in-flight search and emit only the latest result"
        )
        let subject = PassthroughSubject<String, Never>()
        var results: [[Title]] = []

        let publisher = searchPublisher(for: subject.eraseToAnyPublisher())
        publisher
            .sink { value in
                results.append(value)
                if results.count == 1 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        subject.send("first")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            subject.send("second")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            subject.send(completion: .finished)
        }

        wait(for: [expectation], timeout: 2.0)
        XCTAssertEqual(results, [[Title(name: "Result for second")]])
    }

    @MainActor
    func testNoDuplicateSearches() {
        let expectation = XCTestExpectation(
            description: "Should not emit duplicate results for same query"
        )
        let subject = PassthroughSubject<String, Never>()
        var results: [[Title]] = []

        let publisher = searchPublisher(for: subject.eraseToAnyPublisher())
        publisher
            .sink { value in
                results.append(value)
                if results.count == 1 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        subject.send("repeat")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            subject.send("repeat")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            subject.send(completion: .finished)
        }

        wait(for: [expectation], timeout: 2.0)
        XCTAssertEqual(results, [[Title(name: "Result for repeat")]])
    }
}
