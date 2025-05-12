public struct Item {
    let width: Int
}

public func visibleIndices(items: [Item], scrollOffset: Int, viewportWidth: Int) -> [Int] {
    // Solution
    var result: [Int] = []
    var currentOffset = 0

    for (index, item) in items.enumerated() {
        let itemStart = currentOffset
        let itemEnd = currentOffset + item.width
        let viewportStart = scrollOffset
        let viewportEnd = scrollOffset + viewportWidth

        if itemEnd > viewportStart && itemStart < viewportEnd {
            result.append(index)
        }

        currentOffset += item.width
    }

    return result
}
