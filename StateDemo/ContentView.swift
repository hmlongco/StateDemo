//
//  ContentView.swift
//  StateDemo
//
//  Created by Michael Long on 7/12/20.
//  Copyright © 2020 Michael Long. All rights reserved.
//

import SwiftUI

extension MasterViewModel {
    static var shared = MasterViewModel()
}

struct ContentView: View {
//    @ObservedObject var master = MasterViewModel.shared
    let tracker = InstanceTracker("ContentView")
    var body: some View {
        tracker.body {
            NavigationView {
                MasterView()
                    .environmentObject(MasterViewModel.shared)
            }
            .navigationViewStyle(StackNavigationViewStyle())
//            .onReceive(master.$update1) { count in
//                tracker.log("ContentView Update 1 Received \(count)")
//            }
//            .onReceive(master.$update2) { count in
//                tracker.log("ContentView Update 2 Received \(count)")
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
