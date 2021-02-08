import Foundation

struct IANQueue<T>: Queuing {
    private var array: [T] = []
    
    public init() {}
    
    var isEmpty: Bool {
        array.isEmpty
    }
    
    @discardableResult mutating func enqueue(_ element: T) -> Bool {
        array.append(element)
        return true
    }
    
    mutating func dequeue() -> T? {
        if !isEmpty {
            return array.removeFirst()
        } else {
            return nil
        }
    }
    
}
