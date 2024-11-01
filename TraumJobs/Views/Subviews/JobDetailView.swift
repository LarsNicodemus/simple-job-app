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
    @Binding var job: Job?
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 16) {
                Spacer().frame(height: 16)
                HStack {
                    Text(job?.title ?? "")
                        .font(.title)
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
                HStack{
                    Label(job?.company ?? "", systemImage: "bag")
                    Label(job?.location ?? "", systemImage: "location")
                }
                HStack{
                    Image(systemName: (!(job?.isRemote ?? false)) ? "house" : "globe")
                    Text(!(job?.isRemote ?? false) ? "inhouse" : "remote")
                    Text(!(job?.isHybrid ?? false) ? "" : "hybrid")
                }
                Label(job?.jobType.rawValue ?? "", systemImage: "clock")
                VStack{
                    HStack{
                        Spacer()
                        if let imageData = job?.image, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: .infinity)
                                .scaledToFit()
                        } else {
                            Image("testpic")
                                .resizable()
                                .frame(width: .infinity)
                                .scaledToFit()
                        }
                        Spacer()
                    }
                }
                VStack(alignment: .leading){
                    Text("Beschreibung: ")
                        .bold()
                    Text(job?.details ?? "")
                        .font(.body)
                }
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
                    
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text("erstellt am:")
                            Text(job?.postedDate.formatted(.dateTime.year().month(.wide).day()) ?? "")
                            
                        }
                        .font(.system(size: 10))
                        HStack{
                            Text("gültig bis:")
                            Text(job?.expirationDate?.formatted(.dateTime.year().month(.wide).day()) ?? "")
                        }
                        .font(.system(size: 10))
                    }
                    .padding(.top, 100)
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
}

#Preview {
    JobDetailView(
        job: .constant(MOCKJOB))
}
