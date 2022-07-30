//
//  main.swift
//  Swift
//
//  Created by g.shevchenko on 30.07.2022.
//

import Foundation

class IntegerRef: Equatable {
    let value: Int
    init(_ value: Int) {
        self.value = value
    }
}

func ==(lhs: IntegerRef, rhs: IntegerRef) -> Bool {
    return lhs.value == rhs.value
}
