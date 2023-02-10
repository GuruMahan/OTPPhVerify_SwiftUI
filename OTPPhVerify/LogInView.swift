//
//  LogInView.swift
//  FireBaseOTPVerificationPOC
//
//  Created by Guru Mahan on 10/02/23.
//

import SwiftUI

struct LogInView: View {
    @StateObject var otpModel: OTPViewModel = .init()
    
    var body: some View {
        VStack{
            HStack(spacing: 10){
                VStack(spacing: 8){
                    TextField("1", text: $otpModel.code)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                    Rectangle()
                        .fill(otpModel.code == "" ? .gray.opacity(0.35) : .blue)
                        .frame(height: 2)
                }
                .frame(height: 40)
                
                VStack(spacing: 8){
                    TextField("9080439890", text: $otpModel.number)
                        .keyboardType(.numberPad)
                    Rectangle()
                        .fill(otpModel.code == "" ? .gray.opacity(0.35) : .blue)
                        .frame(height: 2)
                }
            }
            .padding(.vertical)
            Button {
                Task{await otpModel.sendOTP()}
            } label: {
                Text("Login")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical,12)
                    .frame(maxWidth: .infinity)
                    .background{
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.blue)
                            .opacity(otpModel.isLoading ? 0 : 1)
                    }
                    .overlay {
                        ProgressView()
                            .opacity(otpModel.isLoading ? 1 : 0)
                    }
                
            }
           // .disabled(otpModel.code == "" || otpModel.number == "")
            .opacity(otpModel.code == "" || otpModel.number == "" ? 0.4 : 1)
        }
        .navigationTitle("Login")
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        background{
            NavigationLink(tag: "VERIFICATION", selection: $otpModel.navigationTag) {
                OTPVerificationView()
                    .environmentObject(otpModel)
            } label: {
               
            }.labelsHidden()

        }
        .alert(otpModel.errorMsg, isPresented: $otpModel.showAlert) {}

    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
