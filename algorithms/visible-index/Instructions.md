## Visible Index Calculator

### Scenario

<img src="assets/home.png" width="200"/>

You're implementing a component (`Shelf`) for the horizontal scrolling of Trending show thumbnails on the 7plus homepage. Each shelf item could have variable. To maintain performance, you want to calculate which items are visible given a scroll offset and viewport width.

Write a function:

```swift
struct Item {
    let width: Int
}

func visibleIndices(items: [Item], scrollOffset: Int, viewportWidth: Int) -> [Int]
```

This function should return the indices of all items that are at least partially visible in the current viewport.

### Example

```swift
let items = [Item(width: 100), Item(width: 150), Item(width: 200), Item(width: 120)]
let scrollOffset = 100
let viewportWidth = 250

// Expected output: [1, 2]
```

## ✅ Solution

```swift
func visibleIndices(items: [Item], scrollOffset: Int, viewportWidth: Int) -> [Int] {
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
```
