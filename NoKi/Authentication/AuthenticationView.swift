//
//  SignInEmailView.swift
//  NoKi
//
//  Created by nguyenbahao on 24/04/2023.
//

import SwiftUI

@MainActor
final class SignInEmailViewModel: ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    
    func signIn()async throws{
        guard !email.isEmpty, !password.isEmpty else{
            print("")
            return
        }
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
    
}
struct AuthenticationView: View {
    
    @StateObject private var ViewModel = SignInEmailViewModel()
    @Binding  var showSignInView: Bool

    var body: some View {
        VStack(alignment: .trailing){
            TextField("Email...", text: $ViewModel.email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            SecureField("Password...", text: $ViewModel.password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            Button {
                Task{
                    do{
                        try await ViewModel.signIn()
                        showSignInView = false
                        return
                    }catch{
                        print(error)
                    }
                }
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            NavigationLink {
            Registeraccount(showSignInView: $showSignInView)

            } label: {
                Text("Register account")
                    .font(.headline)
                    .foregroundColor(.blue)
            }

            Spacer()

                
        }
        .padding(.top)
        .padding()
        .navigationTitle("Log in to Noki ")
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            AuthenticationView(showSignInView: .constant(false))
        }
    }
}
