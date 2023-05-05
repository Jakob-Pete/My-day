//
//  My_Day_WithOutCoreDataLoaded_App.swift
//  My Day(WithOutCoreDataLoaded)
//
//  Created by mac on 3/27/23.
//

import SwiftUI

@main
struct My_Day_WithOutCoreDataLoaded_App: App {
    @State private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
