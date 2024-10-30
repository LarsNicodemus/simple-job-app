//
//  JobDetailView.swift
//  TraumJobs
//
//  Created by Lars Nicodemus on 29.10.24.
//

import SwiftUI
import SwiftData

struct JobDetailView: View {
    @Environment(\.modelContext) private var context
    @Query var jobs: [Job]
    @Binding var job: Job?
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(job?.title ?? "")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                Image(systemName: (!(job?.isFavorite ?? false)) ? "heart" : "heart.fill")
                    .resizable()
                    .foregroundColor(!(job?.isFavorite ?? false) ? .black: .purple)
                    .frame(width: 40, height: 40)
                    .onTapGesture {
                        job?.isFavorite.toggle()
                    }
            }
            .padding(.top, 16)
            Text(job?.details ?? "")
                .font(.body)
                .padding(.vertical)

            VStack(alignment: .leading) {
                Text("Gehalt:")
                    .bold()
                Text(job?.salary ?? 0.0, format: .currency(code: "EUR"))
            }
            

            Text("Fähigkeiten:")
                .font(.headline)
                .padding(.top)
            VStack(alignment: .leading) {
                ForEach(job?.skills ?? []) { skill in

                    Text("- \(skill.title)")
                }
            }
            Spacer()
            HStack{
                Spacer()
                Button {
                    if let jobToDelete = job {
                        context.delete(jobToDelete)
                        job = nil
                    }
                } label: {
                    HStack{
                        Image(systemName: "trash")
                        Text("Löschen")
                    }
                    .foregroundColor(.red)
                }
                Spacer()
            }
            .padding(.top, 16)
            
        }
        .padding()
        .navigationTitle("Job Details")
    }
}

#Preview {
    JobDetailView(
        job: .constant(Job(
            id: UUID(), title: "App Entwickler",
            details: "Entwicklung von iOS- und Android-Apps", salary: 50000,
            isFavorite: true,
            skills: [Skill(title: "SwiftUI"), Skill(title: "Kotlin")])))
}
