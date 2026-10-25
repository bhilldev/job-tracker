//
//  ContentView.swift
//  JobTracker
//
//  Created by Brandon Hill on 10/13/26.
//
import SwiftUI

struct ContentView: View {
    // Identify each tab so buttons can select a destination without creating another screen.
    private enum AppTab: Hashable {
        case home
        case applications
    }

    @State private var jobApplicationsStore = JobApplicationsStore()
    // Start on Home and keep the selected bottom tab in sync with navigation actions.
    @State private var selectedTab: AppTab = .home

    var body: some View {
        // The native tab bar supplies Liquid Glass on iOS 26 and later automatically.
        TabView(selection: $selectedTab) {
            Tab("Home", systemImage: "house", value: AppTab.home) {
                HomeView(store: jobApplicationsStore) {
                    // The Home card's button switches to the existing Applications tab.
                    selectedTab = .applications
                }
            }

            Tab("Applications", systemImage: "briefcase", value: AppTab.applications) {
                JobApplicationsView(store: jobApplicationsStore)
            }
        }
        .tint(Color("AccentGreen"))
        // Match the system tab bar and its labels to the app's existing dark surfaces.
        .preferredColorScheme(.dark)
        .task {
            await jobApplicationsStore.loadJobApplications()
        }
    }
}

#Preview {
    ContentView()
}
