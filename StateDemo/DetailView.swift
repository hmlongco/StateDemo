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

    var boilerplate = "This is some boilplate text."
}

struct DetailView: View {

    @EnvironmentObject var master: MasterViewModel
    @ObservedObject var model: DetailViewModel

    init(item: Item) {
        self.model = DetailViewModel(item: item)
    }

    let tracker = InstanceTracker("DetailView")
    var body: some View {
        tracker.body {
            DetailContentView(model: model)
                .padding()
                .navigationBarTitle(Text("Detail"))
// CRASH - UNCOMMENT THIS CODE TO CRASH APP ON UPDATE
                .onReceive(master.$update1) { count in
                    tracker.log("DetailView Update 1 Received \(count)")
                }
// CRASH - COMMENT ABOVE CODE AND CLICK BUTTON TWICE TO CRASH APP ON UPDATE
                .navigationBarItems(
                    trailing: Button(action: { self.master.update() }) {
                        Text("Update")
                    }
                )
                .onAppear {
                    tracker.log("DetailView onAppear")
                }
        }
    }
}

struct DetailContentView: View {

    var model: DetailViewModel

    let tracker = InstanceTracker("DetailContentView")
    var body: some View {
        tracker.body {
            VStack(spacing: 16) {
                ItemDateView(item: model.item)
                DetailBoilerplateView(text: model.boilerplate)
                Spacer()
            }
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
        tracker.body {
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
