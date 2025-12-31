//
//  LoginView.swift
//  Clean-Architecture-Swift
//
//  Created by Sowmya Bharath on 30/12/25.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel: LoginViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                
                Text("Clean Architecture Demo")
                    .font(Font.title)
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(.roundedBorder)
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(.roundedBorder)
                
                if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
                }
                
                Button("Login") {
                    Task { await viewModel.login() }
                }
                
                if viewModel.isLoading {
                    ProgressView("Logging in...")
                }
            }
            .padding()
            .navigationDestination(isPresented: $viewModel.isLoggedIn) {
                if let user = viewModel.loggedInUser {
                    HomeView(user: user)
                }
            }
        }
    }
}
