//
//  JobAddView.swift
//  TraumJobs
//
//  Created by Lars Nicodemus on 29.10.24.
//

import SwiftData
import SwiftUI

struct JobAddView: View {
    @Environment(\.modelContext) private var context
    @Query var jobs: [Job]
    @Query var skills: [Skill]
    @State private var skillsList: [Skill] = []
    @State var selectedSkills: [Skill] = []
    @State var jobTitle: String = ""
    @State var jobDetails: String = ""
    @State var jobSalary: Double? = nil
    @State var skillTitle: String = ""
    @State private var selectedTitle: String = ""
    @State private var selectedSkill: Skill? = nil
    @State var testSkills: [Skill] = [
        Skill(title: "Test1"),
        Skill(title: "Test2"),
        Skill(title: "Test3"),
    ]
    var body: some View {
        Form {
            VStack(alignment: .leading) {
                Text("Job Titel")
                TextField("Gib hier dden Titel ein...", text: $jobTitle)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray.opacity(0.5)))
            }

            VStack(alignment: .leading) {
                Text("Job Beschreibung")
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $jobDetails)
                        .frame(minHeight: 150)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray.opacity(0.5)))

                    if jobDetails.isEmpty {
                        Text("Gib hier die Beschreibung ein...")
                            .foregroundColor(.gray)
                            .padding(.horizontal, 4)
                            .padding(.vertical, 8)
                            .allowsHitTesting(false)
                    }
                }
            }
            .padding(.vertical, 8)
            VStack(alignment: .leading) {
                Text("Gehalt")
                TextField(
                    "Gib hier das Gehalt an...", value: $jobSalary,
                    format: .currency(code: "EUR")
                )
                .padding(.horizontal, 4)
                .padding(.vertical, 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray.opacity(0.5)))
            }
            VStack(alignment: .leading) {
                Text("Fähigkeiten")
                ForEach(selectedSkills){ skill in
                    Text("- \(skill.title)")
                }
                HStack {
                    Picker("", selection: $selectedSkill) {
                                Text("Wähle eine Fähigkeit").tag(nil as Skill?)
                                ForEach(skills, id: \.self) { skill in
                                    Text(skill.title).tag(skill as Skill?)
                                }
                            }
                    .pickerStyle(.menu)
                    .frame(width: 200, height: 30)
                    Spacer()
                    Button {
                                insertskill()
                    } label: {
                                Image(systemName: "plus.circle")
                            }
                }
            }
            Section {

                HStack {
                    Spacer()
                    Button {
                        insertJob()
                        jobTitle = ""
                        jobDetails = ""
                        jobSalary = nil
                        selectedSkills = []
                        selectedSkill = nil

                    } label: {
                        Text("Speichern")
                            .bold()
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color.gray.opacity(0.5))
                            .cornerRadius(5)
                            .foregroundColor(.blue)
                    }
                    Spacer()
                }

            }
            .listRowBackground(Color.clear)

        }

    }
    
    func insertJob() {
        let job = Job(
            id: UUID(), title: jobTitle, details: jobDetails,
            salary: jobSalary ?? 0.0)
        context.insert(job)
        job.skills = selectedSkills
        
    }
    func insertskill() {
        guard let skill = selectedSkill else { return }
        
        if let index = skills.firstIndex(where: {skill.id == $0.id}) {
            if !selectedSkills.contains(where: { $0.id == skill.id }) {
                selectedSkills.append(skills[index])
            }
        }
//        if !selectedSkills.contains(where: { $0.id == skill.id }) {
//            selectedSkills.append(skill)
//            selectedSkill = nil
//        }
    }
}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: Job.self, Skill.self, configurations: configuration)
    return JobAddView()
        .modelContainer(container)
}
