//
//  Enums.swift
//  TraumJobs
//
//  Created by Lars Nicodemus on 28.10.24.
//

enum JobTitle: String, Identifiable, CaseIterable, Codable {
    
    case fulltime = "Vollzeit"
    case parttime = "Teilzeit"
    case internship = "Praktikum"
    case freelance = "Freiberuflich"
    
    var id: String {
        self.rawValue
    }
}
