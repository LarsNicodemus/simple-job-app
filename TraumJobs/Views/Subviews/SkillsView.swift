//
//  SkillsView.swift
//  TraumJobs
//
//  Created by Lars Nicodemus on 31.10.24.
//

import SwiftUI
import SwiftData

struct SkillsView: View {
    @Environment(\.modelContext) private var context
    @State var skillTitle: String = ""
    @Query var skills: [Skill]
    var body: some View {
        Form{
            TextField("Hier Fähigkeit eintragen...", text: $skillTitle)
            Button{
                let skill = Skill(title: skillTitle)
                context.insert(skill)
                skillTitle = ""
            } label: {
                Text("Fähigkeit anlegen")
            }
            VStack(alignment: .leading){
                Text("Skills List")
                List{
                    ForEach(skills){ skill in
                        Section{
                            VStack{
                                Text("- \(skill.title)")
                            }
                                .onTapGesture {
                                    context.delete(skill)
                                }
                        }
                    }
                }
            }
        }
        
    }
}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Job.self, configurations: configuration)
    return SkillsView()
        .modelContainer(container)
}
