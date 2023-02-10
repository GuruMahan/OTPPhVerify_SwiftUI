//
//  OTPVerificationView.swift
//  FireBaseOTPVerificationPOC
//
//  Created by Guru Mahan on 10/02/23.
//

import SwiftUI

struct OTPVerificationView: View {
    
    @EnvironmentObject var viewModel: OTPViewModel
    @FocusState var activated: OTPField?
    var body: some View {
        NavigationView {
            VStack{
                OTpCondition()
                
                Button {
                    Task{await viewModel.verifyOTP()}
                } label: {
                    Text("verify")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.vertical,12)
                        .frame(maxWidth: .infinity)
                        .background{
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.blue)
                                .opacity(viewModel.isLoading ? 0 : 1)
                        }
                        .overlay {
                            ProgressView()
                                .opacity(viewModel.isLoading ? 1 : 0)
                        }
                }
                .disabled(checkState())
                .opacity(checkState() ? 0.4 : 1)
                .padding(.vertical)
                
                HStack(spacing: 12){
                    Text("Didn't get otp?")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Button("Resend") {
                        
                    }.font(.callout)
                }.frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .frame(maxHeight: .infinity, alignment: .top)
            .navigationTitle("verification")
            .onChange(of: viewModel.otpField) { newValue in
                OTpCondition(value: newValue)
            }
            .alert(viewModel.errorMsg, isPresented: $viewModel.showAlert) {}
        }
        
    }
    
    func checkState()-> Bool{
        for index in 0..<6{
            if viewModel.otpField[index].isEmpty{return true}
            
        }
        return false
    }
    
  func OTpCondition(value:[String]){
      
   //Checking if OTP is pressed
      for index in 0..<6{
          if value[index].count == 6{
              DispatchQueue.main.async {
                  viewModel.otpText = value[index]
                  viewModel.otpField[index] = ""
                  
                  //updating all textfield with value
                  for item in viewModel.otpText.enumerated(){
                      viewModel.otpField[item.offset] = String(item.element)
                  }
              }
              return
          }
      }
      
      
                for index in 0..<5{
                    if value[index].count == 1 && activeStateForIndex(index: index) == activated{
                        activated = activeStateForIndex(index: index + 1)
                    }
                }
        
        for index1 in 1...5{
            if value[index1].isEmpty && !value[index1 - 1].isEmpty{
                activated = activeStateForIndex(index: index1 - 1)
            }
        }
                for index2 in 0..<6 {
                    if value[index2].count > 1{
                        if let lst = value[index2].last{
                            viewModel.otpField[index2] = String(lst)
                        }
                    }
                }
    }
    
    @ViewBuilder func OTpCondition()-> some View{
        HStack(spacing: 14){
            ForEach(0..<6,id: \.self){ index in
                VStack(spacing: 8){
                    TextField("", text: $viewModel.otpField[index])
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .multilineTextAlignment(.center)
                        .focused($activated, equals: activeStateForIndex(index: index))
                    
                    Rectangle()
                        .fill(activated == activeStateForIndex(index: index) ? .blue : .gray.opacity(0.3))
                        .frame(height: 4)
                }
                .frame(width: 40)
            }
        }
        
    }
    
    func activeStateForIndex(index: Int)-> OTPField{
        switch index {
        case 0: return .field1
        case 1: return .field2
        case 2: return .field3
        case 3: return .field4
        case 4: return .field5
        default: return .field6
           
        }
    }
}

struct OTPVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        OTPVerificationView()
    }
}



enum OTPField{
    case field1
    case field2
    case field3
    case field4
    case field5
    case field6
}
