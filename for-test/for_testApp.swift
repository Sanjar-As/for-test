//
//  for_testApp.swift
//  for-test
//
//  Created by Sanjar Aslonov on 10/05/22.
//

import SwiftUI

@main
struct for_testApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
