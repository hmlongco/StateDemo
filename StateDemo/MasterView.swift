//
//  MasterView.swift
//  StateDemo
//
//  Created by Michael Long on 7/27/20.
//  Copyright © 2020 Michael Long. All rights reserved.
//

import SwiftUI
import Combine

struct Item: Identifiable {
    let id = InstanceTracker.count
    let date = Date()
}

class MasterViewModel: ObservableObject {

    @Published var update1 = 0
    @Published var update2 = 0

    let tracker = InstanceTracker("MasterViewModel")
    var cancellable0: AnyCancellable!
    var cancellable1: AnyCancellable!
    var cancellable2: AnyCancellable!

    init() {
        cancellable0 = objectWillChange.sink { (value) in
            self.tracker("Sink 0 recived change notification")
        }
        cancellable1 = $update1.sink { (value) in
            self.tracker("Sink 1 recived value = \(value)")
        }
        cancellable2 = $update2.sink { (value) in
            self.tracker("Sink 2 recived value = \(value)")
        }
    }

    func update() {
        update1 += 1
        update2 += 1
        update1 += 1
        update2 += 1
    }

    @Published var items = [Item]()

    func add() {
        let item = Item()
        items.append(item)
        print("\n### Added \(item); items.count = \(items.count)\n")
    }

}

struct MasterView: View {

    @EnvironmentObject var master: MasterViewModel

    let tracker = InstanceTracker("MasterView")
    var body: some View {
        tracker("List \(master.items.count) items") {
            List {
                ForEach(master.items) { item in
                    NavigationLink(
                        destination: DetailView(item: item)
                    ) {
                        ItemDateView(item: item)
                    }
                }
            }
            .onAppear {
                tracker("MasterView.onAppear")
            }
            .onReceive(master.objectWillChange) { () in
                tracker("MasterView Changed")
            }
            .onReceive(master.$update1) { count in
                tracker("MasterView Update 1 Received \(count)")
            }
            .onReceive(master.$update2) { count in
                tracker("MasterView Update 2 Received \(count)")
            }
//            .onChange(of: trackedValue, perform: { (value) in
//                DispatchQueue.main.async {
//                    self.tracker.log("\n### Begin Update Cycle\n")
//                }
//                tracker.log("Tracked Value Changed = \(value)")
//            })
            .navigationBarTitle(Text("Master"))
            .navigationBarItems(
                trailing: Button(action: { self.master.add() }) {
                    Image(systemName: "plus")
                }
            )
        }
    }
    
}

struct ItemDateView: View {
    let item: Item
    let tracker = InstanceTracker("ItemDateView")
    var body: some View {
        tracker("\(item.date)") { Text("\(item.date, formatter: Self.dateFormatter)") }
    }
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }()
}
