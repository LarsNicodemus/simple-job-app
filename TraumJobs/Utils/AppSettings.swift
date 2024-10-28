//
//  AppSettings.swift
//  TraumJobs
//
//  Created by Lars Nicodemus on 28.10.24.
//

import Foundation

class AppSettings: ObservableObject {
    @Published var fontSize: CGFloat
    @Published var isDarkMode: Bool
    
    init() {
        let storedFontSize = CGFloat(UserDefaults.standard.double(forKey: "fontSize"))
        self.fontSize = storedFontSize == 0 ? 14.0 : storedFontSize
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
    }
    
    private func saveSettings() {
        UserDefaults.standard.set(Double(fontSize), forKey: "fontSize")
        UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
        
    }
    
    func updateFontSize(_ size: CGFloat) {
        fontSize = size
        saveSettings()
    }
    
    func toggleDarkMode() {
        isDarkMode.toggle()
        saveSettings()
    }
}
