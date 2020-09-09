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
    //@ObservedObject var master = MasterViewModel.shared
    let tracker = InstanceTracker("ContentView")
    var body: some View {
        tracker {
            NavigationView {
                AnyView(MasterView())
                    .environmentObject(MasterViewModel.shared)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
