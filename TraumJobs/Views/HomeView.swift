//
//  HomeView.swift
//  TraumJobs
//
//  Created by Lars Nicodemus on 28.10.24.
//

import SwiftUI

struct HomeView: View {
    @State private var selection = 0
    var body: some View {
        TabView(selection: $selection){
            Tab("Start", systemImage: "house.fill", value: 0) {
            }
            Tab("Einstellungen", systemImage: "gearshape.fill", value: 1){
                SettingsView()
            }
        }
    }
}

#Preview {
    HomeView()
}
