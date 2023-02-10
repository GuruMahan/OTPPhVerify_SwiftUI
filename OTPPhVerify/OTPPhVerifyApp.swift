//
//  OTPPhVerifyApp.swift
//  OTPPhVerify
//
//  Created by Guru Mahan on 10/02/23.
//

import SwiftUI
import Firebase
@main
struct OTPPhVerifyApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()

    return true
  }
}
