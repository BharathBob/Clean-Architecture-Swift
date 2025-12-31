# 🧼 Clean Architecture Login App (SwiftUI)

<p align="center">
  <img src="https://developer.apple.com/assets/elements/icons/swift/swift-64x64_2x.png" alt="Swift Logo" />
</p>

A simple **Login → Home** SwiftUI application built using **Clean Architecture principles**, showcasing proper separation of concerns, dependency injection, and state-driven navigation.

---

## ✨ Features

- SwiftUI + `async/await`
- Clean Architecture (Uncle Bob)
- Protocol-driven Dependency Injection
- Testable business logic
- Loading state using `ProgressView`
- Navigation to Home screen on login success
- Personalized welcome message derived from user email

---

## 🧱 Architecture Overview

This project follows Clean Architecture, where:
Business logic is framework-independent
Dependencies always point inward
UI is a pure rendering layer
```text
UI → Presentation → UseCases → Domain ← Data
```

<img width="425" height="419" alt="image" src="https://github.com/user-attachments/assets/bf1dd860-3689-4d4c-8ae8-2cf9240c780a" />

## 📂 Project Structure

```text

📦 CleanAuthApp
├── App
│   ├── CleanAuthApp.swift
│   └── DependencyContainer.swift
│
├── Domain
│   ├── Entities
│   │   └── User.swift
│   └── Errors
│       └── LoginError.swift
│
├── UseCases
│   ├── LoginUseCase.swift
│   └── LoginInteractor.swift
│
├── Data
│   └── Auth
│       └── RemoteAuthRepository.swift
│
├── Presentation
│   └── Login
│       └── LoginViewModel.swift
│
├── UI
│   ├── LoginView.swift
│   └── HomeView.swift
│
└── README.md

```


---

## 🔐 Login Flow

1. User enters email & password
2. `LoginViewModel` triggers `LoginUseCase`
3. Repository returns a `User`
4. ViewModel updates login state
5. SwiftUI navigates to Home screen
6. Home screen welcomes the user by name

---

## 🧠 Domain Layer (Business Model)

```swift
struct User {
    let id: String
    let email: String
    let token: String
}
```

## 🧠 Use Case Layer
```swift
protocol LoginUseCase {
    func login(email: String, password: String) async throws -> User
}
```
## Interactor
```swift
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

```
## 🗄 Data Layer (Infrastructure)
```swift

final class RemoteAuthRepository: AuthRepository {
    func login(email: String, password: String) async throws -> User {
        User(
            id: UUID().uuidString,
            email: email,
            token: "mock_token"
        )
    }
}
```
Can be replaced with:
Firebase
REST API
OAuth
Mock repository for tests

## 🎛 Presentation Layer (ViewModel)

```swift
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

        do {
            let user = try await loginUseCase.login(
                email: email,
                password: password
            )
            loggedInUser = user
            isLoggedIn = true
        } catch {
            errorMessage = "Login failed"
        }

        isLoading = false
    }
}
```
## 🎨 UI Layer (SwiftUI)
```swift
if viewModel.isLoading {
    ProgressView("Logging in...")
}
```
## Home View (Welcome User)
```swift
struct HomeView: View {

    let user: User

    private var displayName: String {
        user.email
            .split(separator: "@")
            .first
            .map { String($0).capitalized } ?? "User"
    }

    var body: some View {
        VStack(spacing: 16) {
            Text("Welcome 👋")
                .font(.title)

            Text(displayName)
                .font(.largeTitle)
                .fontWeight(.bold)
        }
        .padding()
    }
}
```
## 🔀 Navigation Flow
Navigation is driven by state, not imperative code.
```swift
.navigationDestination(isPresented: $viewModel.isLoggedIn) {
    if let user = viewModel.loggedInUser {
        HomeView(user: user)
    }
}
```
✔ ViewModel exposes state
✔ View controls navigation
✔ Clean & testable

## 🔌 Dependency Injection
All wiring happens in one place.
```swift
final class DependencyContainer {

    func makeLoginViewModel() -> LoginViewModel {
        let repository = RemoteAuthRepository()
        let useCase = LoginInteractor(repository: repository)
        return LoginViewModel(loginUseCase: useCase)
    }
}
```
## 🧪 Testing Strategy
Mock AuthRepository
Test LoginInteractor
Test LoginViewModel
No SwiftUI dependency in tests
```swift
final class MockAuthRepository: AuthRepository {
    func login(email: String, password: String) async throws -> User {
        User(id: "1", email: email, token: "test")
    }
}
```

## 📸 Screenshots
<table> <tr> <td align="center" style="padding-right:10px;"> <b>Login Screen</b><br/><br/> <img src="https://github.com/user-attachments/assets/c91b99ff-884b-4636-9330-18e8280fb1bf" width="300" /> </td> <td align="center" style="padding-left:10px;"> <b>Home Screen</b><br/><br/> <img src="https://github.com/user-attachments/assets/25b034c2-a034-4934-bb99-9000cefdf653" width="300" /> </td> </tr> </table>

---

## 🚀 Why Clean Architecture?
```text
✅ Highly testable
🔄 Easy to change APIs or UI
🧠 Clear separation of concerns
📈 Scales well for large teams
🧼 Reduces long-term technical debt
```

## 🛠 Requirements
```text
iOS 15+
Xcode 15+
Swift 5.9+
```

## 📌 Future Improvements
```text
Logout flow
Persist login using Keychain
Coordinator / Router
Feature-based modules
Unit & UI tests
```

## 👨‍💻 Author
```text
Viswa Bharath Dakka
Senior iOS Engineer
```


