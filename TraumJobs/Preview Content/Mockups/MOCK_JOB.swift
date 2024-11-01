//
//  MOCK_JOB.swift
//  TraumJobs
//
//  Created by Lars Nicodemus on 01.11.24.
//
import SwiftUI

func loadImageData(named imageName: String) -> Data? {
    if let uiImage = UIImage(named: imageName) {
        return uiImage.pngData()
    }
    return nil
}

var MOCKJOB = Job(id: UUID(), title: "App Developer", company: "Dreamfactory", location: "Frankfurt a.M.", jobType: JobTitle.fulltime, details: "Als Beratungs­unternehmen für führende Banken und Asset Manager sind wir mit unseren Kunden ganz vorne dabei, wenn es um Innovation, frische Impulse und maß­geschneiderte Software geht. Was neue Technologien und die Finanz­industrie gemeinsam haben? Jede Menge, denn für unsere Kunden sind sie der Weg in die Zukunft. Wir legen Wert auf eine anerkennende Unter­nehmens­kultur, stellen Kompetenz vor Hierarchie und bieten jede Menge Mit­gestaltung. Auch das macht uns immer wieder zum »Great Place to Work«.", isFavorite: false, postedDate: Date(), expirationDate: Date(), isRemote: true, isHybrid: true, skills: [Skill(title: "xcode"),Skill(title: "swiftui"),Skill(title: "kotlin")])
