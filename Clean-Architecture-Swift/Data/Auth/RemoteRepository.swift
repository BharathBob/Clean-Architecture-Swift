//
//  RemoteRepository.swift
//  Clean-Architecture-Swift
//
//  Created by Sowmya Bharath on 31/12/25.
//
import Foundation

protocol AuthRepository {
    func login(email: String, password: String) async throws -> User
}

final class RemoteAuthRepository: AuthRepository {
    func login(email: String, password: String) async throws -> User {
        // Simulated API response
        return User(
            id: UUID().uuidString,
            email: email,
            token: "mock_jwt_token"
        )
    }
}
