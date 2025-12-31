//
//  Clean_Architecture_SwiftApp.swift
//  Clean-Architecture-Swift
//
//  Created by Sowmya Bharath on 30/12/25.
//

import SwiftUI

@main
struct CleanAuthApp: App {
    private let container = DependencyContainer()
    
    var body: some Scene {
        WindowGroup {
            LoginView(
                viewModel: container.makeLoginViewModel()
            )
        }
    }
}
