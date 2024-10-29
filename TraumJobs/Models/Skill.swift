//
//  Skill.swift
//  TraumJobs
//
//  Created by Lars Nicodemus on 29.10.24.
//

import SwiftData
import Foundation

@Model
class Skill {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}
