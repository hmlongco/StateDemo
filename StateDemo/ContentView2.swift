////
////  ContentView.swift
////  StateDemo
////
////  Created by Michael Long on 7/12/20.
////  Copyright © 2020 Michael Long. All rights reserved.
////
//
//import SwiftUI
//
//struct Counter {
//    private static var counter: Int = 0
//    static var count: Int {
//        counter += 1
//        return counter
//    }
//}
//
//struct DebugView<WrappedView:View>: View {
//    var instance = Counter.count
//    let view: WrappedView
//    init(_ view: WrappedView) {
//        print("#\(WrappedView.self).init #\(instance)")
//        self.view = view
//    }
//    var body: some View {
//        print("#\(WrappedView.self).body #\(instance)")
//        return view
//    }
//}
//
//struct ContentView: View {
//
//    var instance: Int = Counter.count
//
//    @EnvironmentObject var master: MasterViewModel
//
//    init() {
//        print("ContentView.init #\(instance)")
//    }
//    var body: some View {
//        print("ContentView.body #\(instance)")
//        return NavigationView {
//            DebugView(MasterView())
//                .navigationBarTitle(Text("Master"))
//                .navigationBarItems(
//                    trailing: Button(action: { self.master.add() }) {
//                        Image(systemName: "plus")
//                    }
//                )
//        }
//    }
//
//}
//
//struct Item: Identifiable {
//    let id = Counter.count
//    let date = Date()
//}
//
//class MasterViewModel: ObservableObject {
//
//    var instance = Counter.count
//
//    @Published var items = [Item]()
//    @Published var updated = 0
//
//    init() {
//        print("MasterViewModel.init #\(instance)")
//    }
//    func add() {
//        print("MasterViewModel.add BEGIN")
//        items.append(Item())
//        print("MasterViewModel.add END")
//    }
//    func update() {
//        print("MasterViewModel.update BEGIN")
//        items += []
//        updated += 1
//        print("MasterViewModel.update END")
//    }
//}
//
//struct MasterView: View {
//
//    var instance: Int = Counter.count
//    @EnvironmentObject var master: MasterViewModel
//
//    init() {
//        print("MasterView.init #\(instance)")
//    }
//    var body: some View {
//        print("MasterView.body #\(instance)" +
//            " building list of \(master.items.count) items")
//        return List {
//            ForEach(master.items) { item in
//                NavigationLink(destination: DetailView(item: item)) {
//                    Text("\(item.date, formatter: dateFormatter)")
//                }
//            }
//        }
//        .onAppear {
//            print("MasterView.appear #\(self.instance)")
//        }
//    }
//}
//
//class DetailViewModel: ObservableObject, CustomStringConvertible {
//
//    var instance: Int = Counter.count
//    let item: Item
//
//    init(item: Item) {
//        self.item = item
//        print("DetailViewModel.init \(self)")
//    }
//    deinit {
//        print("DetailViewModel.deinit \(self)")
//    }
//    var description: String {
//        "#\(instance) item \(item.id)" +
//            " - \(item.date.description.dropLast(6))"
//    }
//}
//
//struct DetailView: View {
//
//    var instance = Counter.count
//    @ObservedObject var model: DetailViewModel
//    @EnvironmentObject var master: MasterViewModel
//
//    init(item: Item) {
//        self.model = DetailViewModel(item: item)
//        print("DetailView.init #\(instance) model \(model)")
//    }
//    var body: some View {
//        print("DetailView.body #\(instance) model \(model)")
//        return VStack(spacing: 16) {
//            Text("Model #\(model.instance)")
//            Text("View #\(instance)")
//            Text("MasterViewModel Update Count \(master.updated)")
//            Text("\(model.item.date, formatter: dateFormatter)")
//            NavigationLink(destination: DetailView(item: model.item)) {
//                Text("More")
//            }
//            Spacer()
//        }
//        .padding(50)
//        .onAppear {
//            print("DetailView.appear #\(self.instance)")
//        }
//        .navigationBarTitle(Text("Detail"))
//        .navigationBarItems(
//            trailing: Button(action: { self.master.update() }) {
//                Text("Update")
//            }
//        )
//    }
//}
//
//struct WrappedDetailView: View {
//    var instance = Counter.count
//    let item: Item
//    init(item: Item) {
//        self.item = item
//        print("WrappedDetailView.init #\(instance) item \(item)")
//    }
//    var body: some View {
//        print("WrappedDetailView.body #\(instance) item \(item)")
//        return DetailView(item: item)
//    }
//}
//
//private let dateFormatter: DateFormatter = {
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateStyle = .medium
//    dateFormatter.timeStyle = .medium
//    return dateFormatter
//}()
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
