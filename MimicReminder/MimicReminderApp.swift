//
//  MimicReminderApp.swift
//  MimicReminder
//
//  Created by benlin on 2021/5/11.
//

import SwiftUI

@main
struct MimicReminderApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
