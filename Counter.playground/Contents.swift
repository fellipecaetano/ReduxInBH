//: Playground - noun: a place where people can play

import UIKit
import Redux

enum CounterAction: Action {
    case increment(Int)
    case decrement(Int)
}

let store = Store<Int>(initialState: 0) { state, action in
    return state
}

_ = store.subscribe { state in
    print("Current counter: \(state)")
}
