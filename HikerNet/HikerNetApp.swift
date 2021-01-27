//
//  HikerNetApp.swift
//  HikerNet
//
//  Created by Michael Koohang on 1/26/21.
//

import SwiftUI

@main
struct HikerNetApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
