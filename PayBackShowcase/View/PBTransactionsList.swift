//
//  PBTransactionsList.swift
//  PayBackShowcase
//
//  Created by Manish Parihar on 27.06.23.
//

import SwiftUI

struct PBTransactionsList: View {
    
    @StateObject var viewModel = PBViewModel()
    
    var body: some View {
        
    NavigationView {
            List {
                ForEach(viewModel.showTransaction, id: \.self) { mytransaction in
                    VStack(alignment: .leading) {
                        Text("PartnerName:  \(mytransaction.partnerDisplayName)")
                            .font(.system(size: 16, weight: .bold, design: .monospaced))
                            .foregroundColor(.blue)
                            .padding(.bottom,2)
                        

                        HStack {
                            if let amount = mytransaction.transactionDetail?.value?.amount {
                                Text("Amount: \(String(amount))")
                            } else {
                                Text("N/A")
                            }
                        
                            Text(mytransaction.transactionDetail?.value?.currency ?? "")
                        }
                            .padding(.bottom,2)
                            .font(.system(size: 14, weight: .bold, design: .monospaced))
                            .foregroundColor(.gray)
                        
                        Text(mytransaction.transactionDetail?.description?.rawValue ?? "")
                            .font(.system(size: 14, weight: .bold, design: .monospaced))
                            .foregroundColor(.gray)
                            
                        
                        HStack {
                            
                           
                        }
                        .padding(.trailing,10)
                        
                    }
                    .frame(height:80)
                }
            }
            .navigationTitle("PAYBACK")
            .onAppear{
                viewModel.fetchDataFromAPI()
            }
        }
    }
}

struct PBTransactionsList_Previews: PreviewProvider {
    static var previews: some View {
        PBTransactionsList()
    }
}
