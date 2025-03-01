import SwiftUI

struct ContentView: View {
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
    ContentView()
}
