//
//  JobAddView.swift
//  TraumJobs
//
//  Created by Lars Nicodemus on 29.10.24.
//

import SwiftUI
import SwiftData

struct JobAddView: View {
    @Environment(\.modelContext) private var context
    @Query var jobs: [Job]
    @State var jobTitle: String = ""
    @State var jobDetails: String = ""
    @State var jobSalary: Double? = nil
    
    var body: some View {
        Form{
            VStack(alignment: .leading){
                Text("Jobtitle")
                TextField("Enter Job Title here...", text: $jobTitle)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 8)
                    .overlay(RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray.opacity(0.5)))
            }
            
            VStack(alignment: .leading) {
                           Text("Job Description")
                           ZStack(alignment: .topLeading) {
                               TextEditor(text: $jobDetails)
                                   .frame(minHeight: 150)
                                   .overlay(RoundedRectangle(cornerRadius: 5)
                                       .stroke(Color.gray.opacity(0.5)))
                               
                               if jobDetails.isEmpty {
                                   Text("Enter job description here...")
                                       .foregroundColor(.gray)
                                       .padding(.horizontal, 4)
                                       .padding(.vertical, 8)
                                       .allowsHitTesting(false)
                               }
                           }
                       }
            .padding(.vertical,8)
            VStack(alignment: .leading){
                Text("Salary")
                TextField("Enter Salary here...", value: $jobSalary, format: .currency(code: "EUR"))
                    .padding(.horizontal, 4)
                    .padding(.vertical, 8)
                    .overlay(RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray.opacity(0.5)))
            }
            Section {
                
                HStack{
                    Spacer()
                        Button {
                            insertJob()
                            jobTitle = ""
                            jobDetails = ""
                            jobSalary = nil
                        } label: {
                                Text("Speichern")
                                    .bold()
                                    .padding(.horizontal)
                                    .padding(.vertical, 8)
                                    .background(.gray).opacity(0.5)
                                    .cornerRadius(5)
                                    .foregroundColor(.blue).opacity(1.0)
                        }
                    Spacer()
                    }
                
                
            }
            .listRowBackground(Color.clear)

        }
        
        
    }
    func insertJob(){
        let job = Job(id: UUID(), title: jobTitle, details: jobDetails, salary: jobSalary ?? 0.0, skills: [])
        context.insert(job)
        
    }
}






#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Job.self, Skill.self, configurations: configuration)
    return JobAddView()
        .modelContainer(container)
}
