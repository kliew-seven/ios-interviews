import XCTest

public final class VisibleIndexExampleTestSuite: XCTestSuite {
    public init() {
        super.init(name: "VisibleIndexExampleTestSuite")
        let exampleTest = VisibleIndexTests(selector: #selector(VisibleIndexTests.testExampleCase))
        addTest(exampleTest)
    }
}

public final class VisibleIndexCompleteTestSuite: XCTestSuite {
    public init() {
        super.init(name: "VisibleIndexCompleteTestSuite")
        addTest(VisibleIndexTests.defaultTestSuite)
    }
}

final class VisibleIndexTests: XCTestCase {

    func testExampleCase() {
        let items = [Item(width: 100), Item(width: 150), Item(width: 200), Item(width: 120)]
        let indices = visibleIndices(items: items, scrollOffset: 100, viewportWidth: 250)
        XCTAssertEqual(indices, [1, 2])
    }

    func testAllVisible() {
        let items = [Item(width: 50), Item(width: 50), Item(width: 50)]
        let indices = visibleIndices(items: items, scrollOffset: 0, viewportWidth: 200)
        XCTAssertEqual(indices, [0, 1, 2])
    }

    func testNoneVisible() {
        let items = [Item(width: 100), Item(width: 100)]
        let indices = visibleIndices(items: items, scrollOffset: 300, viewportWidth: 50)
        XCTAssertEqual(indices, [])
    }

    func testPartialOverlap() {
        let items = [Item(width: 100), Item(width: 100), Item(width: 100)]
        let indices = visibleIndices(items: items, scrollOffset: 50, viewportWidth: 100)
        XCTAssertEqual(indices, [0, 1])
    }
}
