//
//  HomeView.swift
//  Clean-Architecture-Swift
//
//  Created by Sowmya Bharath on 31/12/25.
//
import SwiftUI

struct HomeView: View {
    
    let user: User
    
    private var displayName: String {
        user.email
            .split(separator: "@")
            .first
            .map { String($0).capitalized } ?? "User"
    }
    
    var body: some View {
        VStack(spacing: 24) {
            
            Image("swift_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
            
            Text("Welcome 👋")
                .font(.title2)
            
            Text(displayName)
                .font(.largeTitle)
                .fontWeight(.bold)
        }
        .padding()
    }
}
