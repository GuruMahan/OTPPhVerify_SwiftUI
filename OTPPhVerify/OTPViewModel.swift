//
//  OTPViewModel.swift
//  FireBaseOTPVerificationPOC
//
//  Created by Guru Mahan on 10/02/23.
//

import SwiftUI
import Firebase

class OTPViewModel: ObservableObject {
    @Published var number: String = ""
    @Published var code: String = ""
    @Published var otpText: String = ""
    @Published var otpField:[String] = Array(repeating: "", count: 6)
    @Published var isLoading = false
    @Published var verificationCode = ""
    //MARK: Error
    @Published var showAlert: Bool = false
    @Published var errorMsg: String = ""
    @Published var navigationTag: String?
    @AppStorage("log_status") var log_status = false
    
    func sendOTP()async{
        if isLoading {return}
        do{
            isLoading = true
            let result =  try await
            PhoneAuthProvider.provider().verifyPhoneNumber("+\(code)\(number)", uiDelegate: nil)
            DispatchQueue.main.async {
                self.isLoading = false
                self.verificationCode = result
                self.navigationTag = "VERIFICATION"
            }
        }
        catch{
            handelError(error: error.localizedDescription)
        }
    }
    
    func handelError(error: String){
        DispatchQueue.main.async {
            self.isLoading = false
            self.errorMsg = error
            self.showAlert.toggle()
        }
    }
    func  verifyOTP() async{
        do{
            DispatchQueue.main.async {
                self.isLoading = true
            }
          
            var otpString = ""
            for index in otpField {
               otpString += index
            }
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationCode, verificationCode: otpString)
                let _ = try await Auth.auth().signIn(with: credential)
                DispatchQueue.main.async {[self] in
                    isLoading = false
                }
        }
        catch {
            handelError(error: error.localizedDescription)
        }
    }
}
