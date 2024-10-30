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
    @State private var skills: [Skill] = []
    @State var jobTitle: String = ""
    @State var jobDetails: String = ""
    @State var jobSalary: Double? = nil
    @State var skillTitle: String = ""

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
                ForEach(skills) { skill in
                    Text("- \(skill.title)")
                }
                HStack {
                    TextField("Gib hier die Fähigkeiten ein...", text: $skillTitle)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray.opacity(0.5)))
                    Button {
                        insertskill()
                        skillTitle = ""
                    }
                    
                    label: {
                        Image(systemName: "plus")
                    }
                    .disabled(skillTitle.isEmpty)
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
                        skills.removeAll()

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
            salary: jobSalary ?? 0.0, skills: skills)
        context.insert(job)

    }
    func insertskill() {
        
        if !skillTitle.isEmpty {
            let skill = Skill(title: skillTitle)
            skills.append(skill)
        }

    }
}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: Job.self, Skill.self, configurations: configuration)
    return JobAddView()
        .modelContainer(container)
}
