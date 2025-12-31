//
//  LoginUseCase.swift
//  Clean-Architecture-Swift
//
//  Created by Sowmya Bharath on 30/12/25.
//

protocol LoginUseCase {
    func login(email: String, password: String) async throws -> User
}

final class LoginInteractor: LoginUseCase {
    private let repository: AuthRepository
    
    init(repository: AuthRepository) {
        self.repository = repository
    }
    
    func login(email: String, password: String) async throws -> User {
        guard password.count >= 6 else {
            throw LoginError.invalidPassword
        }
        return try await repository.login(email: email, password: password)
    }
}
