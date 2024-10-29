//
//  HomeView.swift
//  TraumJobs
//
//  Created by Lars Nicodemus on 28.10.24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @State private var selection = 0
    var body: some View {
        TabView(selection: $selection){
            Tab("Start", systemImage: "house.fill", value: 0) {
                JobsView()
            }
            Tab("Add Job", systemImage: "plus.circle", value: 1){
                JobAddView()
            }
            Tab("Einstellungen", systemImage: "gearshape.fill", value: 2){
                SettingsView()
            }
        }
    }
}


#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Job.self, Skill.self, configurations: configuration)
    return HomeView()
        .modelContainer(container)
}
