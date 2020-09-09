//
//  DetailView.swift
//  StateDemo
//
//  Created by Michael Long on 7/27/20.
//  Copyright © 2020 Michael Long. All rights reserved.
//

import SwiftUI

class DetailViewModel: ObservableObject {

    let item: Item
    let tracker = InstanceTracker("DetailViewModel")

    init(item: Item) {
        self.item = item
    }

    var boilerplate: String {
        "You're viewing model #\(tracker.instance)."
    }
}

struct DetailView: View {

    @EnvironmentObject var master: MasterViewModel
    @ObservedObject var model: DetailViewModel

    init(item: Item) {
        self.model = DetailViewModel(item: item)
    }

    let tracker = InstanceTracker("DetailView")
    var body: some View {
        tracker {
            DetailContentView(model: model)
                .padding()
                .navigationBarTitle(Text("Detail"))
// CRASH - UNCOMMENT THIS CODE TO IMMEDIATELY CRASH APP ON PRESSING UPDATE
//                .onReceive(master.$update1) { count in
//                    tracker.log("DetailView Update 1 Received \(count)")
//                }
// CRASH - COMMENT ABOVE CODE AND TAP BUTTON TWICE TO CRASH APP
                .navigationBarItems(
                    trailing: Button(action: {
//                        OperationQueue.main.addOperation {
//                            self.tracker.log("\n### Begin Update Cycle\n")
//                        }
                        DispatchQueue.main.async {
                            self.tracker("\n### Begin Update Cycle\n")
                        }
                        self.tracker("\n### Begin Update")
                        self.master.update()
                        self.tracker("### End Update\n")
                    }) {
                        Text("Update")
                    }
                )
                .onAppear {
                    tracker("DetailView onAppear")
                }
        }
    }
}

struct DetailContentView: View {

    var model: DetailViewModel

    @State var uuid = UUID()

    let tracker = InstanceTracker("DetailContentView")
    var body: some View {
        tracker {
            VStack(spacing: 16) {
                ItemDateView(item: model.item)
                DetailStateView()
                DetailBoilerplateView(text: model.boilerplate)
//                Button(action: {
//                    DispatchQueue.main.async {
//                        self.tracker.log("\n### Begin State Update Cycle\n")
//                    }
//                    self.tracker.log("\n### Begin State Update")
//                    self.trackedValue += 1
//                    self.tracker.log("### End State Update\n")
//                }) {
//                    Text("State \(trackedValue)")
//                }
                Spacer()
            }
        }
    }

}

struct DetailStateView: View {
    @State var uuid = UUID()
    let tracker = InstanceTracker("DetailStateView")
    var body: some View {
        tracker("\(uuid)") {
            Text("\(uuid)")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
}

struct DeeperView: View {
    @EnvironmentObject var master: MasterViewModel
    var body: some View {
        VStack {
            Button("Update") {
                self.master.update()
            }
            Spacer()
        }
        .padding()
    }
}

struct DetailBoilerplateView: View {
    var text: String
    let tracker = InstanceTracker("DetailBoilerplateView")
    var body: some View {
        tracker(text) {
            Text(text)
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
}

struct WrappedDetailView: View {
    var instance = InstanceTracker.count
    let item: Item
    init(item: Item) {
        self.item = item
        print("WrappedDetailView.init #\(instance) item \(item)")
    }
    var body: some View {
        print("WrappedDetailView.body #\(instance) item \(item)")
        return DetailView(item: item)
    }
}
