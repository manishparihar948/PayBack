//
//  PayBackShowcaseApp.swift
//  PayBackShowcase
//
//  Created by Manish Parihar on 27.06.23.
//

import SwiftUI

@main
struct PayBackShowcaseApp: App {

    @ObservedObject var networkManager = NetworkManager()
    @State private var showTransactionsList = false

    var body: some Scene {
        WindowGroup {
            
            if !networkManager.isConnected {
                VStack {
                    Text("Network Error. Please Retry")
                        .foregroundColor(.red)
                        .padding()
                    Button("Retry") {
                       // PBTransactionsList()
                        showTransactionsList = true
                    }
                    .padding()
                        .background(Color.blue)
                            .foregroundColor(.white)
                                .cornerRadius(8)
                }
                .padding()
            }
            else  {
                PBTransactionsList()

            }
            
           // PBTransactionsList()
        }
    }
}
