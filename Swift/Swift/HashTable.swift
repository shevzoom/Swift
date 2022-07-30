//
//  HashTable.swift
//  Swift
//
//  Created by g.shevchenko on 30.07.2022.
//

import Foundation

struct HashTable<Key: Hashable, Value> {
    
    typealias Element = (key: Key, value: Value)
    typealias Bucket = [Element]
    
    var buckets: [Bucket]
    
    private(set) var count = 0
    
    var isEmpty: Bool {
        return count == 0
    }
    
    init(capacity: Int) {
        assert(capacity > 0)
        buckets = Array<Bucket>(repeating: [], count: capacity)
    }
}
