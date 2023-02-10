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
    @AppStorage("log_status") var log_status = false
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if log_status{
                    Text("Home")
                        .navigationTitle("Home")
                }
                else{
                LogInView()
                }
               
            }
          
        }
        }
    }


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()

    return true
  }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) async -> UIBackgroundFetchResult {
        return .noData
    }
}
