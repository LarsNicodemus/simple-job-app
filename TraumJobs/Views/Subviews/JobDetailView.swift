//
//  JobDetailView.swift
//  TraumJobs
//
//  Created by Lars Nicodemus on 29.10.24.
//

import SwiftUI

struct JobDetailView: View {
    @Binding var job: Job?
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack{
                Text(job!.title)
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                        Image(systemName: "heart")
                    .resizable()
                    .frame(width: 40, height: 40)
                    
                    }

            Text(job!.details)
                        .font(.body)
                        .padding(.vertical)

            if job!.isFavorite {
                        Text("❤️ Favorit")
                            .font(.headline)
                            .foregroundColor(.red)
                    }

                    Text("Fähigkeiten:")
                        .font(.headline)
                        .padding(.top)

            ForEach(job!.skills) { skill in
                Text("- \(skill.title)")
                            .font(.subheadline)
                    }

                    Spacer()
                }
                .padding()
                .navigationTitle("Job Details")
            }
        }

        #Preview {
            JobDetailView(job: .constant(Job(id: UUID(),title: "App Entwickler", details: "Entwicklung von iOS- und Android-Apps", salary: 50000, isFavorite: true, skills: [Skill(title: "SwiftUI"), Skill(title: "Kotlin")])))
        }
