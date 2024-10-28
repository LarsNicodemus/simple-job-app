//
//  LoginView.swift
//  TraumJobs
//
//  Created by Lars Nicodemus on 28.10.24.
//

import SwiftUI

struct LoginView: View {
    @AppStorage("username")
    private var username: String = "Guest"
    var body: some View {
        VStack {
            Text("Welcome, \(username)!")
            TextField("Enter your name", text: $username)
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
