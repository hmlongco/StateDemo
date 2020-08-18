//
//  AppDelegate.swift
//  StateDemo
//
//  Created by Michael Long on 7/12/20.
//  Copyright © 2020 Michael Long. All rights reserved.
//

import SwiftUI

@main
struct AppStateDemo: App {

//    let master = MasterViewModel()

    let tracker = InstanceTracker("AppStateDemo")
    var body: some Scene {
        tracker.body {
            WindowGroup {
                ContentView()
            }
        }
//                .environmentObject(master)
    }

}
