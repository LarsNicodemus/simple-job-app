//
//  Job.swift
//  TraumJobs
//
//  Created by Lars Nicodemus on 29.10.24.
//

import Foundation
import SwiftData

@Model
class Job {
    var id: UUID
    var title: String
    var company: String
    var location: String
    var jobType: JobTitle
    var details: String
    var salary: Double? = nil
    var isFavorite: Bool = false
    var postedDate: Date
    var expirationDate: Date?
    var isRemote: Bool = false
    var isHybrid: Bool = false
    @Relationship(inverse: \Skill.jobs)
    var skills: [Skill]
    var image: Data?
    
    init(id: UUID, title: String, company: String, location: String, jobType: JobTitle, details: String, salary: Double? = nil, isFavorite: Bool, postedDate: Date = Date(), expirationDate: Date? = nil, isRemote: Bool, isHybrid: Bool, skills: [Skill] = [], image: Data? = nil) {
        self.id = id
        self.title = title
        self.company = company
        self.location = location
        self.jobType = jobType
        self.details = details
        self.salary = salary
        self.isFavorite = isFavorite
        self.postedDate = postedDate
        self.expirationDate = expirationDate
        self.isRemote = isRemote
        self.isHybrid = isHybrid
        self.skills = skills
        self.image = image
    }
}



