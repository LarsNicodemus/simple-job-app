//
//  JobsView.swift
//  TraumJobs
//
//  Created by Lars Nicodemus on 29.10.24.
//

import SwiftUI
import SwiftData

struct JobsView: View {
    @Query var jobs: [Job]
    @State private var selectedJob: Job? = nil
 
    @State private var showJobDetailSheet = false
    var body: some View {
        List{
            ForEach(jobs){job in
                Section{
                    VStack(alignment: .leading){
                        Text(job.title)
                            .bold()
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
                }
            }
        }
        .sheet(isPresented: $showJobDetailSheet) {
                    if let job = selectedJob {
                        JobDetailView(job: job)
                    }
                }
    }
}



#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Job.self, Skill.self, configurations: configuration)
    return JobsView()
        .modelContainer(container)
}
