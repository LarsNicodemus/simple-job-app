//
//  HomeView.swift
//  TraumJobs
//
//  Created by Lars Nicodemus on 28.10.24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var context
    @Query var users: [AppUser]
    @StateObject private var settings = AppSettings()
    @State private var selection = 0
    @State private var currentUser: AppUser?

    var body: some View {
        
//        if currentUser == nil {
//            LoginView()
//                .padding()
//        }
//        else {
            TabView(selection: $selection){
                Tab("Start", systemImage: "house.fill", value: 0) {
                    JobsView()
                }
//                if currentUser?.isCreator == true {
                    Tab("Add Job", systemImage: "plus.circle", value: 1){
                        TabView {
                            JobAddView()
                            SkillsView()
                        }
                        .tabViewStyle(.page)
//                    }
                }
                Tab("Favorite", systemImage: "heart.fill", value: 2){
                    JobsFavoriteView()
                }
                Tab("Einstellungen", systemImage: "gearshape.fill", value: 3){
                    SettingsView()
                }
            }
            .font(.system(size: settings.fontSize))
//        }
    }
    
}



#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Job.self, AppUser.self, configurations: configuration)
    return HomeView()
        .modelContainer(container)
}
