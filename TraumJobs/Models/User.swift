//
//  User.swift
//  TraumJobs
//
//  Created by Lars Nicodemus on 01.11.24.
//
import SwiftData
import Foundation

@Model
class AppUser {
    var id: UUID
    var userName: String
    var email: String
    var password: String
    var isCreator: Bool
    
    init(id: UUID = UUID(), userName: String, email: String, password: String, isCreator: Bool) {
        self.id = id
        self.userName = userName
        self.email = email
        self.password = password
        self.isCreator = isCreator
    }
}
