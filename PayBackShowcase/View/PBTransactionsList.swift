//
//  PBTransactionsList.swift
//  PayBackShowcase
//
//  Created by Manish Parihar on 27.06.23.
//

import SwiftUI

struct PBTransactionsList: View {
    
    @ObservedObject var networkManager = NetworkManager()

    
    @StateObject var viewModel = PBViewModel()
    
    // ItemData sorted date wise
    var sortedTransactions: [ItemData] {
           return viewModel.showTransaction.sorted { (transaction1, transaction2) -> Bool in
               if let date1 = convertStringToDate(dateString: transaction1.transactionDetail?.bookingDate ?? ""),
                  let date2 = convertStringToDate(dateString: transaction2.transactionDetail?.bookingDate ?? "") {
                   return date1 > date2
               }
               return false
           }
       }
    
    //    MARK: - Body (List sort by Booking Date )
    var body: some View {
        NavigationView {
            
            // If monitor detects valid network connection
            if networkManager.isConnected {
                
                List(sortedTransactions, id: \.self) { itemData in
                    
                    NavigationLink(destination: PBTransactionDetailList(itemData: itemData)) {
                               
                            VStack(alignment: .leading) {
                                   
                                           Text(itemData.partnerDisplayName)
                                               .font(.system(size: 16, weight: .bold, design: .monospaced))
                                               .foregroundColor(.blue)
                                               .padding(.bottom,2)
                                           
                                           HStack {
                                               if let amount = itemData.transactionDetail?.value?.amount {
                                                   Text("Amount: \(String(amount))")
                                               } else {
                                                   Text("N/A")
                                               }
                                               
                                               Text(itemData.transactionDetail?.value?.currency ?? "")
                                           }
                                           .padding(.bottom,2)
                                           .font(.system(size: 14, weight: .medium, design: .monospaced))
                                           .foregroundColor(.gray)
                                           
                                           Text(itemData.transactionDetail?.description?.rawValue ?? "")
                                               .padding(.bottom,2)
                                               .font(.system(size: 14, weight: .medium, design: .monospaced))
                                               .foregroundColor(.gray)
                                           
                                           HStack {
                                               if let date = convertStringToDate(dateString: itemData.transactionDetail!.bookingDate) {
                                                   let formattedDate = formatDate(date: date)
                                                   Text("Booking Date: \(formattedDate)")
                                                   
                                               } else {
                                                   Text("Invalid Date")
                                               }
                                           }
                                           .padding(.trailing,10)
                                           .font(.system(size: 12, weight: .medium, design: .monospaced))
                                           .foregroundColor(.gray)
                              }
                                .frame(height:80)
                               
                    }
                }
                .navigationTitle("PAYBACK")
                .onAppear {
                    viewModel.fetchDataFromAPI()
                }
                
                 
                            
            } else {
                // Otherwise, show something else
                Button {
                    print("Handle action..")
                } label: {
                    Text("Network Error Please Retry")
                        .padding()
                        .font(.headline)
                        .foregroundColor(Color(.systemBlue))
                }
                .frame(width: 140)
                .background(Color.white)
                .clipShape(Capsule())
                .padding()
            }
        }
    }
    
   
    func convertStringToDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // Format of the input date string
        if let date = dateFormatter.date(from: dateString) {
            return date
        } else {
            return nil
        }
    }
    
    func formatDate(date: Date) -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateStyle = .medium // Choose the desired date style
           
           return dateFormatter.string(from: date)
    }
    
}

// MARK: - Previews
struct PBTransactionsList_Previews: PreviewProvider {
    static var previews: some View {
        PBTransactionsList()
    }
}



