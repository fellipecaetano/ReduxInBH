//: Playground - noun: a place where people can play

import UIKit
import Redux

enum CounterAction: Action {
    case increment(Int)
    case decrement(Int)
}

let store = Store<Int>(initialState: 0) { state, action in
    switch action {
    case CounterAction.increment(let amount):
        return state + amount
    case CounterAction.decrement(let amount):
        return state - amount
    default:
        return state
    }
}

let unsubscribe = store.subscribe { state in
    print("Current counter: \(state)")
}

store.dispatch(CounterAction.increment(5))
store.dispatch(CounterAction.decrement(3))
store.dispatch(CounterAction.increment(7))

unsubscribe()

store.dispatch(CounterAction.decrement(1))
