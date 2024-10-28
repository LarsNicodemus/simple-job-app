//
//  NotificationSettingsView.swift
//  TraumJobs
//
//  Created by Lars Nicodemus on 28.10.24.
//

import SwiftUI

struct NotificationSettingsView: View {
   @AppStorage("notifyNewJobs") private var notifyNewJobs = true
   @AppStorage("notifyUpdates") private var notifyUpdates = true
   @AppStorage("notifyMessages") private var notifyMessages = true
    @Binding var showNotificationSettings: Bool
   var body: some View {
       NavigationView {
           Form {
               Toggle("Neue Jobs", isOn: $notifyNewJobs)
               Toggle("App Updates", isOn: $notifyUpdates)
               Toggle("Nachrichten", isOn: $notifyMessages)
           }
           .navigationTitle("Benachrichtigungen")
           .navigationBarItems(trailing: Button("Fertig") {
               showNotificationSettings.toggle()
           })
       }
   }
}

#Preview {
    NotificationSettingsView(showNotificationSettings: .constant(true))
}
