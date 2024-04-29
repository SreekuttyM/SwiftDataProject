//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Sreekutty Maya on 29/04/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var showingUpcomingOnly = false

    @Environment(\.modelContext) var modelContext
//    @Query(filter: #Predicate<User> { user in
//        user.name.localizedStandardContains("R") &&
//        user.city == "London"
//    }, sort: \User.name) var users: [User]
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate),
    ]
    @Query(filter: #Predicate<User> { user in
        if user.name.localizedStandardContains("R") {
            if user.city == "London" {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }, sort: \User.name) var users: [User]
    var body: some View {
        NavigationStack {
            UsersView(minimumJoinDate: showingUpcomingOnly ? .now : .distantPast, sortOrder: sortOrder)

            .navigationTitle("Users")
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\User.name),
                                SortDescriptor(\User.joinDate),
                            ])

                        Text("Sort by Join Date")
                            .tag([
                                SortDescriptor(\User.joinDate),
                                SortDescriptor(\User.name)
                            ])
                    }
                }
                
                
            }
        }
    }
}

#Preview {
    ContentView()
}
