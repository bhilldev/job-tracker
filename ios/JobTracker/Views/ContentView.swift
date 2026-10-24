//
//  ContentView.swift
//  JobTracker
//
//  Created by Brandon Hill on 10/13/26.
//
import SwiftUI

struct ContentView: View {
    @State private var jobApplicationsStore = JobApplicationsStore()

    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                HomeView(store: jobApplicationsStore)
            }

            Tab("Applications", systemImage: "briefcase") {
                JobApplicationsView(store: jobApplicationsStore)
            }
        }
        .tint(Color("AccentGreen"))
        .task {
            await jobApplicationsStore.loadJobApplications()
        }
    }
}

#Preview {
    ContentView()
}
