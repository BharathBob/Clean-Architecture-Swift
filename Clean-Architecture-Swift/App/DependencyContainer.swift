//
//  DependencyContainer.swift
//  Clean-Architecture-Swift
//
//  Created by Sowmya Bharath on 30/12/25.
//

import Foundation

final class DependencyContainer {
    
    // MARK: - Repositories
    
    private lazy var authRepository: AuthRepository = {
        RemoteAuthRepository()
    }()
    
    // MARK: - Use Cases
    
    private lazy var loginUseCase: LoginUseCase = {
        LoginInteractor(repository: authRepository)
    }()
    
    // MARK: - ViewModels
    
    func makeLoginViewModel() -> LoginViewModel {
        LoginViewModel(loginUseCase: loginUseCase)
    }
}
