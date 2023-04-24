//
//  Registeraccount.swift
//  NoKi
//
//  Created by nguyenbahao on 24/04/2023.
//

import SwiftUI

@MainActor
final class RegisterAccountModel: ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    
    func Register()async throws{
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or Password found")
            return
        }
        try await AuthenticationManager.shared.createUser(email: email, password: password)
    }
}

struct Registeraccount: View {
    @StateObject private var ViewModel = RegisterAccountModel()
    @Binding var showSignInView: Bool

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
                        try await ViewModel.Register()
                        showSignInView = false
                        return
                    }catch{
                        print(error)
                    }
                }
            } label: {
                Text("Register")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Register Account")
    }
}
struct Registeraccount_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            Registeraccount(showSignInView: .constant(false))
        }
    }
}
