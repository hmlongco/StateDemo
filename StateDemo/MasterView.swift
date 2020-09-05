//
//  MasterView.swift
//  StateDemo
//
//  Created by Michael Long on 7/27/20.
//  Copyright © 2020 Michael Long. All rights reserved.
//

import SwiftUI

struct Item: Identifiable {
    let id = InstanceTracker.count
    let date = Date()
}

class MasterViewModel: ObservableObject {

    @Published var items = [Item]()

    @Published var update1 = 0
    @Published var update2 = 0

    let tracker = InstanceTracker("MasterViewModel")

    func add() {
        let item = Item()
        items.append(item)
        print("\n### Added \(item); items.count = \(items.count)\n")
    }

    func update() {
        print("\n### Begin counter update 1 = \(update1)")
        update1 += 1
        update1 += 1
        print("### End counter update 1 = \(update1)")
        print("\n### Begin counter update 2 = \(update2)")
        update2 += 1
        update2 += 1
        print("### End counter update 2 = \(update2)\n")
    }

}

struct MasterView: View {

    @EnvironmentObject var master: MasterViewModel

    let columns: [GridItem] =
        Array(repeating: .init(.flexible(), alignment: .leading), count: 1)

    let tracker = InstanceTracker("MasterView")
    var body: some View {
        tracker.body("List \(master.items.count) items") {
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
                tracker.log("MasterView.onAppear")
            }
            .onReceive(master.$update1) { count in
                tracker.log("MasterView Update 1 Received \(count)")
            }
            .onReceive(master.objectWillChange) { () in
                tracker.log("MasterView Changed")
            }
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
        tracker.body("\(item.date)") { Text("\(item.date, formatter: Self.dateFormatter)") }
    }
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }()
}
