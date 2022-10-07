//
//  CryptoTradingAppApp.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 24/09/2022.
//

import SwiftUI

@main
struct CryptoTradingAppApp: App {
    @StateObject private var vm_homeView = VM_HomeView()
    @StateObject private var vm_exchangeListView = VM_ExchangeListView()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm_homeView)
            .environmentObject(vm_exchangeListView)
        }
    }
}
