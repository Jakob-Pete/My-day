//
//  SettingsView.swift
//  My Day(WithOutCoreDataLoaded)
//
//  Created by mac on 3/27/23.
//

import SwiftUI


struct SettingsView: View {
    @Binding var darkModeEnabled: Bool
    var body: some View {
        NavigationView {
            
            Form {
                
                Section(header: Text("Display"),
                        footer: Text("System settings")) {
                    Toggle(isOn: $darkModeEnabled) {
                        Text("Dark mode")
                    }
                    .onChange(of: darkModeEnabled) { _ in
                        DarkMode.shared.handleDarkMode(darkMode: darkModeEnabled)
                    }
                    }
                }
            }
        .navigationTitle("Settings")
        }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(darkModeEnabled: .constant(false))
    }
}
