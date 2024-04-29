//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Sreekutty Maya on 29/04/2024.
//

import SwiftUI
import SwiftData
@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: User.self)
    }
}
