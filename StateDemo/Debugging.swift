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
    init(_ name: String) {
        self.name = name
        print("\(name).init #\(instance)")
    }
    deinit {
        print("\(name).deinit #\(instance)")
    }
    func body<Result>(_ message: String? = nil, _ result: () -> Result) -> Result {
        print("\(name).body #\(instance) - enter")
        if let message = message { print(message) }
        defer { print("\(name).body #\(instance) - exit") }
        return result()
    }
}

struct DebugView<WrappedView:View>: View {
    let instance = InstanceTracker.count
    let view: WrappedView
    init(_ view: WrappedView) {
        self.view = view
        print("\(WrappedView.self).init #\(instance) \(viewDescription)")
    }
    var body: some View {
        print("\(WrappedView.self).body #\(instance) \(viewDescription)")
        return view
    }
    var viewDescription: String {
        (view as? CustomStringConvertible)?.description ?? ""
    }
}

struct DebugStackView<WrappedView:View>: View {
    let instance = InstanceTracker.count
    let view: WrappedView
    init(_ view: WrappedView) {
        self.view = view
        print("\(WrappedView.self).init #\(instance) \(viewDescription)")
    }
    var body: some View {
        print("\(WrappedView.self).body #\(instance) \(viewDescription)")
        return VStack {
            Text("Instance #\(instance)")
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
            view
        }
    }
    var viewDescription: String {
        (view as? CustomStringConvertible)?.description ?? ""
    }
}

// View Specific Debugging

extension Item: CustomStringConvertible {
    var description: String {
        "item \(self.id) - \(self.date)"
    }
}

extension DetailViewModel: CustomStringConvertible {
    var description: String {
        item.description
    }
}

extension DetailView: CustomStringConvertible {
    var description: String {
        "model \(model.description)"
    }
}

