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
        log("\(name).init() #\(instance)")
    }
    deinit {
        log("\(name).deinit() #\(instance)")
    }
    func body<Result>(_ message: String? = nil, _ result: () -> Result) -> Result {
        log("\(name).body #\(instance) {")
        Self.indent += 2
        if let message = message {
            log(message)
        }
        defer {
            Self.indent -= 2
            log("}")
        }
        return result()
    }
    func log(_ string: String) {
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
