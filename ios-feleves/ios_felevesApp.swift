//
//  ios_felevesApp.swift
//  ios-feleves
//
//  Created by Bence Papp on 2022. 03. 14..
//

import SwiftUI

@main
struct ios_felevesApp: App {
    var network = Network()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(network)
        }
    }
}
