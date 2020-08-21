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
    @Published var updated = 0

    let tracker = InstanceTracker("MasterViewModel")

    func add() {
        let item = Item()
        items.append(item)
        print("\n### Added \(item); items.count = \(items.count)\n")
    }

    func update() {
        updated += 1
        print("\n### Updated counter \(updated)\n")
    }

}

struct MasterView: View {

    @EnvironmentObject var master: MasterViewModel

    let tracker = InstanceTracker("MasterView")
    var body: some View {
        tracker.body("- Building list of \(master.items.count) items") {
            List {
                ForEach(master.items) { item in
                    NavigationLink(
                        destination: DetailView(item: item)
                    ) {
                        ItemDateView(date: item.date)
                    }
                }
            }
            .onAppear {
                print("- MasterView onAppear")
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
    var date: Date
    var body: some View {
        Text("\(date, formatter: Self.dateFormatter)")
    }
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }()
}
