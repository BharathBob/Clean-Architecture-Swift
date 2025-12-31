//
//  LoginViewModel.swift
//  Clean-Architecture-Swift
//
//  Created by Sowmya Bharath on 30/12/25.
//
import Foundation
import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isLoggedIn = false
    
    private(set) var loggedInUser: User?
    
    private let loginUseCase: LoginUseCase
    
    init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
    }
    
    func login() async {
        isLoading = true
        errorMessage = nil
        // async work
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        do {
            let user = try await loginUseCase.login(
                email: email,
                password: password
            )
            self.loggedInUser = user
            self.isLoggedIn = true   // ✅ triggers navigation
            print("Logged in user:", user.email)
        } catch {
            errorMessage = "Login failed"
        }
        
        isLoading = false
    }
}
