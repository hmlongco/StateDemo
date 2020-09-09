//
//  Debugging.swift
//  StateDemo
//
//  Created by Michael Long on 7/27/20.
//  Copyright © 2020 Michael Long. All rights reserved.
//

import SwiftUI

class InstanceTracker {
    static var count: Int {
        counter += 1
        return counter
    }
    let instance = InstanceTracker.count
    let name: String
    private static var counter: Int = 0
    private static var indent: Int = 0
    init(_ name: String) {
        self.name = name
        self("\(name).init() #\(instance)")
    }
    deinit {
        self("\(name).deinit() #\(instance)")
    }
    func callAsFunction<Result>(_ message: String? = nil, _ result: () -> Result) -> Result {
        self("\(name).body #\(instance) {")
        Self.indent += 2
        if let message = message {
            self(message)
        }
        defer {
            Self.indent -= 2
            self("}")
        }
        return result()
    }
    func callAsFunction(_ string: String) {
        print(String(repeating: " ", count: Self.indent) + string)
    }
}

struct DebugView<WrappedView:View>: View {
    let instance = InstanceTracker.count
    let view: WrappedView
    init(_ view: WrappedView) {
        self.view = view
        print("\(WrappedView.self).init #\(instance)")
    }
    var body: some View {
        print("\(WrappedView.self).body #\(instance)")
        return view
    }
}
