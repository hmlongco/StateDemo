//
//  ContentView.swift
//  StateDemo
//
//  Created by Michael Long on 7/12/20.
//  Copyright © 2020 Michael Long. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var master = MasterViewModel()
    let tracker = InstanceTracker("ContentView")
    var body: some View {
        tracker.body {
            NavigationView {
                MasterView()
                    .environmentObject(master)
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
