//
//  Job.swift
//  TraumJobs
//
//  Created by Lars Nicodemus on 29.10.24.
//

import SwiftData
import Foundation

@Model
class Job {
    var id: UUID
    var title: String
    var details: String
    var salary: Double? = nil
    var isFavorite: Bool = false
    @Relationship var skills: [Skill]
    
    init(id: UUID, title: String, details: String, salary: Double?, isFavorite: Bool = false,  skills: [Skill]) {
        self.id = id
        self.title = title
        self.details = details
        self.salary = salary
        self.skills = skills
    }
}
