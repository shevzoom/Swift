//
//  WeakObject.swift
//  Swift
//
//  Created by g.shevchenko on 30.07.2022.
//

import Foundation

class WeakObject<T: AnyObject>: Equatable, Hashable {
    
    weak var object: T?
    
    init(object: T) {
        self.object = object
    }

    var hashValue: Int {
        if let object = self.object { return unsafeAddressOf(object).hashValue }
        else { return 0 }
    }
    
    func == <T> (lhs: WeakObject<T>, rhs: WeakObject<T>) -> Bool {
        return lhs.object === rhs.object
    }
}
