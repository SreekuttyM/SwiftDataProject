//
//  EditUserView.swift
//  SwiftDataProject
//
//  Created by Sreekutty Maya on 29/04/2024.
//

import SwiftUI
import SwiftData

struct EditUserView: View {
    @Bindable var user: User
    @Environment(\.modelContext) var modelContext
    @Query(sort: \User.name) var users: [User]
    @State private var path = [User]()

    var body: some View {
        NavigationStack(path: $path) {
            List(users) { user in
                NavigationLink(value: user) {
                    Text(user.name)
                }
            }
            .navigationTitle("Users")
            .navigationDestination(for: User.self) { user in
                EditUserView(user: user)
            }.toolbar {
                Button("Add User", systemImage: "plus") {
                    let user = User(name: "", city: "", joinDate: .now)
                    modelContext.insert(user)
                    path = [user]
                }
            }
        }
    }
}

#Preview {
    do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: User.self, configurations: config)
            let user = User(name: "Taylor Swift", city: "Nashville", joinDate: .now)
            return EditUserView(user: user)
                .modelContainer(container)
        } catch {
            return Text("Failed to create container: \(error.localizedDescription)")
        }
}
