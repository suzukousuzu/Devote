//
//  DevoteApp.swift
//  Devote
//
//  Created by 鈴木航太 on 2024/02/21.
//

import SwiftUI

@main
struct DevoteApp: App {
    let persistenceController = PersistenceController.shared
    
    @AppStorage("isDarkMode") var isDarkModel: Bool = false

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(isDarkModel ? .dark : .light)
        }
    }
}
