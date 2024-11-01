//
//  LoginView.swift
//  TraumJobs
//
//  Created by Lars Nicodemus on 28.10.24.
//

import SwiftData
import SwiftUI

struct LoginView: View {
    @Environment(\.modelContext) private var context
    @Query var users: [AppUser]
    @State private var currentUser: AppUser?
    @AppStorage("username1")
    private var username1: String = "Guest"
    @State private var username: String = ""
    {
        didSet {
            username1 = username
        }
    }
    @State private var usermail: String = ""
    @State private var userpassword: String = ""
    @State var isCreator: Bool = false

    var body: some View {

        if currentUser == nil {
            Text("Welcome, \(username1)!")
                .padding(.vertical)
            VStack(alignment: .leading) {
                TextField("Username eingeben..", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: username) { oldValue, newValue in
                        username1 = newValue
                    }
                TextField("E-Mail eingeben..", text: $usermail)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                SecureField("Passwort eingeben..", text: $userpassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Label {
                    Text("Wollen sie Stellen inserieren?")
                } icon: {
                    Image(systemName: isCreator ? "checkmark.square" : "square")
                        .onTapGesture {
                            isCreator.toggle()
                        }
                        .padding(.vertical)

                }
                HStack{
                    Spacer()
                    Button("Login"){
                        setUser()
                    }
                    .buttonStyle(.borderedProminent)
                    Spacer()
                }
                .padding(.vertical)
            }

        }
        //        VStack {
        //            Text("Welcome, \(username)!")
        //            TextField("Enter your name", text: $username)
        //        }
        //        .padding()
    }
    func setUser() {
        
        if let index = users.firstIndex(where: {username == $0.userName || usermail == $0.email}) {
            currentUser = users[index]
        } else {
            let user = AppUser(userName: username, email: usermail, password: userpassword, isCreator: isCreator)
            currentUser = user
        }
    }
    func syncUser() {
        username1 = username
    }
    private func loadAppUser() {
        // Lade den ersten Benutzer oder setze den Benutzer, falls er noch nicht gesetzt ist
        if currentUser == nil {
            if let user = users.first {
                currentUser = user
            } else {
                print("Kein Benutzer gefunden")
                // Alternativ einen Standard-Benutzer erstellen
                let newUser = AppUser(
                    userName: "StandardUser", email: "user@example.com",
                    password: "password", isCreator: false)
                context.insert(newUser)
                currentUser = newUser
            }
        }
    }
}

#Preview {
    LoginView()
}
