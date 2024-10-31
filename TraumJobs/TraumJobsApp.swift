import SwiftUI

@main
struct TraumJobsApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .modelContainer(for: [
                    Job.self,
                    Skill.self
                                ])

        }
    }
}
