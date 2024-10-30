//
//  JobsFavoriteView.swift
//  TraumJobs
//
//  Created by Lars Nicodemus on 30.10.24.
//

import SwiftUI
import SwiftData

struct JobsFavoriteView: View {
    @Environment(\.modelContext) private var context
    
    @Query(filter: #Predicate<Job> {job in
        job.isFavorite == true
    }, sort: \Job.title, order: .forward) var jobs: [Job]

    @Query var skills: [Skill]
    @State private var selectedJob: Job? = nil
 
    @State private var showJobDetailSheet = false
    var body: some View {
        List{
            ForEach(jobs){job in
                Section{
                    VStack(alignment: .leading){
                        HStack{
                            Text(job.title)
                                .bold()
                            Spacer()
                            Image(systemName: !job.isFavorite ? "heart" : "heart.fill")
                                .resizable()
                                .foregroundColor(!job.isFavorite ? .black: .purple)
                                .frame(width: 24, height: 24)
                        }
                        Spacer().frame(height: 12)
                        Text(job.details)
                        Spacer().frame(height: 12)
                        Text(job.salary ?? 0.0 , format: .currency(code: "EUR"))
                            .italic()
                            .underline(color: .gray)
                    }
                    .onTapGesture {
                                            selectedJob = job
                                            showJobDetailSheet = true
                                        }
                    .swipeActions(edge: .trailing) {
                                            Button(role: .destructive) {
                                                context.delete(job)
                                            } label: {
                                                Label("Delete", systemImage: "trash")
                                            }
                                            
                                            Button {
                                                job.isFavorite.toggle()
                                            } label: {
                                                Label("Favorite", systemImage: job.isFavorite ? "heart.fill" : "heart")
                                            }
                                            .tint(.purple)
                                        }
                }
            }
        }
        .sheet(isPresented: $showJobDetailSheet) {
            JobDetailView(job: $selectedJob)
                .presentationDetents([.medium, .large])
        }
        .onChange(of: selectedJob) { newValue, transaction in
            if newValue != nil {
                showJobDetailSheet = false
            }
        }
        
    }

}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Job.self, Skill.self, configurations: configuration)
    return JobsFavoriteView()
        .modelContainer(container)
}
