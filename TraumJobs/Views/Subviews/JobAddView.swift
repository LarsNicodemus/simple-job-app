//
//  JobAddView.swift
//  TraumJobs
//
//  Created by Lars Nicodemus on 29.10.24.
//

import SwiftData
import SwiftUI
import PhotosUI


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
    @State var expirationDate: Date = Date()
    @State var remoteWork: Bool = false
    @State var hybridWork: Bool = false
    @State var companyTitle: String = ""
    @State var locationTitle: String = ""
    @State var jobType: JobTitle = .fulltime
    @State private var companyImage: PhotosPickerItem?
    var body: some View {
        
        Form{
            VStack(alignment: .leading){
                Text("Job anlegen")
                    .font(.headline)
                    
            }
            .listRowSeparator(Visibility.hidden)
            VStack(alignment: .leading) {
                Text("Job Titel")
                TextField("Gib hier den Job Titel ein...", text: $jobTitle)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray.opacity(0.5)))
            }
            .padding(.vertical, 8)
            VStack(alignment: .leading) {
                Text("Firmen Name")
                TextField("Gib hier den Name der Firma ein...", text: $companyTitle)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray.opacity(0.5)))
            }
            .padding(.vertical, 8)
            VStack(alignment: .leading){
                Label {
                            Text("Remote")
                        } icon: {
                            Image(systemName: remoteWork ? "checkmark.square" : "square")
                                .onTapGesture {
                                    remoteWork.toggle()
                                }
                        }
                Label {
                            Text("Hybrid")
                        } icon: {
                            Image(systemName: hybridWork ? "checkmark.square" : "square")
                                .onTapGesture {
                                    hybridWork.toggle()
                                }
                        }
                
            }
            .padding(.vertical, 8)
            VStack(alignment: .leading){
                Text("Art der Anstellung")
                Picker(selection: $jobType) {
                    ForEach(JobTitle.allCases){ title in
                        Text(title.rawValue).tag(title)
                    }
                } label: {
                    
                }
                .pickerStyle(.segmented)

            }
            .padding(.vertical, 8)
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
            .padding(.vertical, 8)
            VStack{
                DatePicker("gültig bis", selection: $expirationDate, displayedComponents: .date)
            }
            .padding(.vertical, 8)
            
                HStack{
                    Spacer()
                    PhotosPicker(selection: $companyImage, matching: .images) {
                        HStack {
                            Text("Bild auswählen")
                            Image(systemName: companyImage != nil ? "folder.fill" : "folder")
                        }
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    Spacer()
                
            }
            .padding(.vertical, 8)
            Section {

                HStack {
                    Spacer()
                    Button {
                        insertJob()
                        jobTitle = ""
                        companyTitle = ""
                        locationTitle = ""
                        jobDetails = ""
                        jobSalary = nil
                        selectedSkills = []
                        selectedSkill = nil
                        jobType = .fulltime
                        expirationDate = Date()
                        remoteWork = false
                        hybridWork = false

                    } label: {
                        Text("Speichern")
                            .bold()
                            .padding(8)
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    Spacer()
                }

            }
            .listRowBackground(Color.clear)

        }

    }
    
    func insertJob() {
        let job = Job(id: UUID(), title: jobTitle, company: companyTitle, location: locationTitle, jobType: jobType, details: jobDetails,salary: jobSalary ?? 0.0, isFavorite: false, expirationDate: expirationDate, isRemote: remoteWork, isHybrid: hybridWork)
        
        context.insert(job)
        Task {
            guard let imageData = try await companyImage?.loadTransferable(type: Data.self) else {
                return
            }
            job.image = imageData
            companyImage = nil
            try? context.save()
        }
        job.skills = selectedSkills
        
    }
    func insertskill() {
        guard let skill = selectedSkill else { return }
        
        if let index = skills.firstIndex(where: {skill.id == $0.id}) {
            if !selectedSkills.contains(where: { $0.id == skill.id }) {
                selectedSkills.append(skills[index])
            }
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
