//
//  SettingsView.swift
//  TraumJobs
//
//  Created by Lars Nicodemus on 28.10.24.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) private var context
    @Query var users: [AppUser]
    @State private var currentUser: AppUser?
    @StateObject private var settings = AppSettings()
    @AppStorage("username") private var username = ""
    @AppStorage("email") private var email = ""
    @AppStorage("birthDate") private var birthDate = Date()
    @AppStorage("location") private var location = ""
    @AppStorage("notificationsEnabled") private var notificationsEnabled = false
    @AppStorage("language") private var language = "Deutsch"
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("fontSize") private var fontSize = 14.0
    @State var isCreator: Bool = false
    @State private var showNotificationSettings = false

    let languages = ["Deutsch", "English", "Français", "Español"]
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Persönliche Informationen")) {
                    TextField("Benutzername", text: $username)
                    TextField("E-Mail", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    DatePicker(
                        "Geburtsdatum", selection: $birthDate,
                        displayedComponents: .date)
                    TextField("Stadt", text: $location)
                    Label {
                        Text("Wollen sie Stellen inserieren?")
                    } icon: {
                        Image(systemName: (currentUser?.isCreator ?? false) ? "checkmark.square" : "square")
                            .onTapGesture {
                                currentUser?.isCreator.toggle()
                            }
                    }
                }
                Section(header: Text("Benachrichtigungen")) {
                    Toggle(
                        "Benachrichtigung aktivieren",
                        isOn: $notificationsEnabled)
                    if notificationsEnabled {
                        Button("Benachrichtigungseinstellungen") {
                            showNotificationSettings.toggle()
                        }
                    }
                }
                Section(header: Text("Darstellung")) {
                    Picker("Sprache", selection: $language) {
                        ForEach(languages, id: \.self) { language in
                            Text(language)
                        }
                    }
                }
                Toggle("Dark Mode", isOn: Binding(
                    get: { settings.isDarkMode },
                    set: { _ in settings.toggleDarkMode() }
                ))

                VStack(alignment: .leading) {
                    Text("Schriftgröße")
                        .font(.system(size: settings.fontSize))
                    Slider(value: Binding(
                        get: { settings.fontSize },
                        set: { settings.updateFontSize($0) }
                    ), in: 12...20, step: 1) {
                        Text("Schriftgröße")
                            .font(.system(size: settings.fontSize))
                    } minimumValueLabel: {
                        Text("A")
                    } maximumValueLabel: {
                        Text("A")
                            .font(.title)
                    }
                    Text("Aktuelle Größe: \(Int(fontSize))")
                }

                Section {
                    HStack {
                        Spacer()
                        Button {
                            resetSettings()
                        } label: {
                            Text("Einstellungen zurücksetzen")
                                .bold()
                                .padding(8)
                                .foregroundColor(.white)
                                
                        }
                        
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                        Spacer()
                    }
                    }
                .listRowBackground(Color.clear)
                    
                }
            }
            .font(.system(size: settings.fontSize))
            .navigationTitle("Einstellungen")
            .preferredColorScheme(settings.isDarkMode ? .dark : .light)
            .sheet(isPresented: $showNotificationSettings) {
                NotificationSettingsView(
                    showNotificationSettings: $showNotificationSettings)
                .presentationDetents([.medium, .large])
            }
        }
    
    func resetSettings() {
        username = ""
        email = ""
        birthDate = Date()
        location = ""
        notificationsEnabled = false
        language = "Deutsch"
        isDarkMode = false
        settings.isDarkMode = false
        settings.fontSize = 14.0
        fontSize = 14.0
    }
}

#Preview {
    SettingsView()
}
